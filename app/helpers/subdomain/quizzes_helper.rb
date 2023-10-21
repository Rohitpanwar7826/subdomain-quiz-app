module Subdomain::QuizzesHelper
  def quiz_enrollments_exits(quiz)
    quiz_enrollment = quiz.quiz_enrollments.where(subdomain_user_id: current_user.id).first
    return true if quiz_enrollment&.to_do? || quiz_enrollment&.in_progress?
    false
  end

  def exam_date_not_past?(quiz)
    test_date_time = DateTime.parse(quiz.test_date_time.to_s) + Rational(quiz.duration, 1440)
    DateTime.now < test_date_time
  end
end
