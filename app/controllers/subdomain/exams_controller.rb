class Subdomain::ExamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz, only: [:show, :create, :final_assessment, :base_line_assessment]
  before_action :set_current_question, only: [:show]
  before_action :authorize_quiz_enrollment, only: [:show, :create]
  layout 'student'

  def index
  end

  def show
  end

  # main content
  def create
    set_current_question_for_create

    response = handle_report_create
    respond_to do |format|
      if response[:success]
        set_current_question
        format.turbo_stream
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  # At begining content
  def base_line_assessment
    Subdomain::BaseLineAssessment.call(@quiz, current_user.id)
    set_current_question
  end

  # show final assessments
  def final_assessment
    set_current_question_for_create

    response = handle_report_create
    Subdomain::MarkQuizEnrollmentComplete.call(current_user, @quiz)
    respond_to do |format|
      if response[:success]
        format.turbo_stream
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_quiz
      @quiz = Subdomain::Quiz.find(params[:id] || params[:exam_id])
    end

    def handle_report_create
      Subdomain::CreateReportRecord.call(@quiz, @question, current_user, params[:answer])
    end

    def authorize_quiz_enrollment
      @quiz_enrollment = @quiz.quiz_enrollments.find_by(subdomain_user_id: current_user.id)

      if !@quiz_enrollment.present?
        flash[:alert] = 'You are not enrolled to this quiz'
        redirect_to subdomain_root_path
      elsif !(@quiz_enrollment.to_do? || @quiz_enrollment.in_progress?)
        flash[:alert] = 'This test has been completed'
        redirect_to subdomain_root_path
      end
    end

    def set_current_question
      service_response = Subdomain::GetCurrentQuestion.call(current_user, @quiz)
      @question = service_response[:question]
      @has_next_question = service_response[:has_next_question]
    end

    def set_current_question_for_create
      @question = @quiz.questions.find(params[:question_id])
    end

    def get_quiz_enrollment
      @quiz.quiz_enrollments.find_by(subdomain_user_id: current_user.id)
    end
end
