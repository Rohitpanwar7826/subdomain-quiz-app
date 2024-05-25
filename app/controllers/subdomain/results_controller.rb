class Subdomain::ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_result_questions, only: [:show]

  def index
    @results = policy_scope(Subdomain::Result)
  end

  def show
  end

  def student_result
    @reports = Subdomain::Report.where(subdomain_user_id: params[:student_id], subdomain_quiz_id: params[:id])
  end

  private
  def set_result_questions
    @reports = Subdomain::Report.where(subdomain_user_id: current_user.id, subdomain_quiz_id: params[:id])
  end 
end
