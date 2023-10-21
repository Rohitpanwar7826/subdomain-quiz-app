class Subdomain::EnrollStudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz, only: [:create]

  def index
    @quizzes = Subdomain::Quiz.soon.where(is_published: true).order(created_at: :desc)
    @enroll_students = @quizzes.includes(:quiz_enrollments)
  end

  def create
    @is_quiz_enrollment_new = true
    quiz_enrollment = current_user.quiz_enrollments.find_by(subdomain_quiz_id: params[:enroll_student][:subdomain_quiz_id])
    if quiz_enrollment.present?
      quiz_enrollment.destroy
      @is_quiz_enrollment_new = false
    else
      current_user.quiz_enrollments.create(permit_enroll_student_params)
    end
  end
  
  private
  def permit_enroll_student_params
    params.require(:enroll_student).permit(:subdomain_quiz_id)    
  end
  
  def set_quiz
    @quiz = Subdomain::Quiz.find(params[:enroll_student][:subdomain_quiz_id])
  end
end
