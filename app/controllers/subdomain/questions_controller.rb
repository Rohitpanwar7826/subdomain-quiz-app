class Subdomain::QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz

  def new
    authorize @quiz
    @quiz.questions.build
  end
  
  def create
    authorize @quiz
    @quiz.assign_attributes(question_params)

    respond_to do |format|
      if @quiz.save
        schedule_job_quiz_report if @quiz.questions.present? && !@quiz.is_schedule_job?
        format.html{ redirect_to subdomain_root_path }
      else
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  
  private
    def set_quiz
      @quiz = Subdomain::Quiz.find(params[:quiz_id])
    end

    def question_params
      params.require(:subdomain_quiz).permit(
        questions_attributes: [:id, :question, :weight, :correct, options: [:a, :b, :c, :d]]
      )
    end


    def schedule_job_quiz_report
      jid = Subdomain::ScheduleQuizJob.perform_in((@quiz.test_date_time + @quiz.duration.minutes), Current.account_id, @quiz.id)
      @quiz.update({jid: jid, is_published: true})
    end
end
