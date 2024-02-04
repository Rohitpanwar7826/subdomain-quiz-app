
class Subdomain::QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_quiz, only: [:new]
  before_action :find_quiz_by_param, only: [:show]
  layout 'teacher'


  def index
    authorize Subdomain::Quiz
    @quizzes = current_user.quizzes.soon
  end

  def new
    authorize @quiz
  end

  def show
    authorize @quiz
  end

  def edit
  end

  def create
    @quiz = Subdomain::Quiz.new(generate_params_with_test_time_formate)
    authorize @quiz

    respond_to do |format|
      if @quiz.save
        format.turbo_stream
      else
        format.turbo_stream{ render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    def initialize_quiz
      @quiz = Subdomain::Quiz.new
    end

    def delete_additional_keys(permited_params)
      [:test_time_hour, :test_time_minute, :test_time_ampm].each do |symbol_key|
        permited_params.delete(symbol_key)
      end
    end

    def generate_params_with_test_time_formate
      permited_params = permit_quiz_params.merge(subdomain_user_id: current_user.id)
      date = Date.parse(permited_params[:test_date_time])

      time = "#{permited_params[:test_time_hour]}:#{permited_params[:test_time_minute]} #{permited_params[:test_time_ampm]}"
      datetime_str = "#{date} #{time}"

      test_datetime = Chronic.parse(datetime_str)
      permited_params["test_date_time"] = test_datetime
      delete_additional_keys(permited_params)
      permited_params
    end

    def permit_quiz_params
      params.require(:subdomain_quiz).permit(:title, :total_questions, :is_published, :test_date, :duration, :branch, :year, :test_date_time, :test_time_hour, :test_time_minute, :test_time_ampm)
    end

    def find_quiz_by_param
      @quiz = Subdomain::Quiz.find(params[:id])
    end
end
