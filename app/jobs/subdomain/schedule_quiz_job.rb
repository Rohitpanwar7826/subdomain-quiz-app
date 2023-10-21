class Subdomain::ScheduleQuizJob < BaseJob
  include Sidekiq::Worker

  def perform(account_id, quiz_id)
    batch = Sidekiq::Batch.new
    batch.description = "Schedule to handle all the after create quiz complete logics"
    batch.jobs do
      perform_for_tenant(account_id) do
        quiz = find_quiz_by_id(quiz_id)
        return unless quiz.present?
        enrolled_quizzes = quiz.quiz_enrollments
        mark_quiz_to_complete(quiz)
        mark_all_enrollments_to_not_taken_or_complete(enrolled_quizzes)
        prepare_result_for_complete_quiz_enrollments(enrolled_quizzes.complete)
      end
    end
  end

  def mail_report_cards_to_students_callback(status, options, batch)
  end

  def prepare_result_for_complete_quiz_enrollments(quiz_enrollments)
    quiz_enrollments.find_each do |quiz_enrollment|
      process_for_quiz_enrollment(quiz_enrollment)
    end
  end

  def process_for_quiz_enrollment(quiz_enrollment)
    user = quiz_enrollment.user
    reports = quiz_enrollment.quiz.reports_by_user(user.id)
    total_marks = reports.map { |report| report.weight.to_i }.sum
    user_marks = reports.to_a.inject(0) do |user_total, current_report|
      user_total+= current_report.is_correct ? current_report.weight.to_i : 0
      user_total
    end
    build_result_for_user(quiz_enrollment, user, total_marks, user_marks)
  end

  def build_result_for_user(quiz_enrollment, user, total_marks, user_total)
    result = user.results.create(build_result_params(quiz_enrollment, total_marks, user_total))
    raise result.errors.full_messages.join(', ') if result.errors.any?
  end

  def build_result_params(quiz_enrollment, total, user_total)
    {
      subdomain_quiz_id: quiz_enrollment.quiz.id,
      subdomain_quiz_enrollment_id: quiz_enrollment.id,
      total: total,
      out_of: user_total,
      pass_or_fail: Subdomain::PassFail.call(total, user_total)
    }
  end

  def find_quiz_by_id(quiz_id)
    Subdomain::Quiz.find_by(id: quiz_id)
  end

  def mark_all_enrollments_to_not_taken_or_complete(enrolled_quizzes)
    enrolled_quizzes.find_each do |enrollment|
      enrollment.in_progress? ? enrollment.complete! : enrollment.to_do? ? enrollment.not_token! : nil
    end
  end

  def mark_quiz_to_complete(quiz)
    quiz.complete!
  end
end

