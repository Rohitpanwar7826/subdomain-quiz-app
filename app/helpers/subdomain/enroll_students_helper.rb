module Subdomain::EnrollStudentsHelper
  def find_student_enroll_or_not(current_user, quiz)
    enroll_student_quiz = current_user.quiz_enrollments.where(subdomain_quiz_id: quiz.id)&.first
    enroll_student_quiz.present? ? "<span id='quiz-test-#{quiz.id}' class='p-1 bg-danger' >Unenroll</span>".html_safe : "<span class='p-1' id='quiz-test-#{quiz.id}' >Eroll</span>".html_safe
  end

  def complete_span
    "<span class='btn btn-info' >COMPLETE</span>".html_safe
  end
end
