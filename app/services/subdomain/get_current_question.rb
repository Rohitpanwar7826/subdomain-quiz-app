module Subdomain
  class GetCurrentQuestion < Base
    class << self
      POSSIBLE_FOR_NEXT_QUESTION = 2
      def call(current_user, quiz)
        process(current_user, quiz)
      end

      def process(current_user, quiz)
        attempt_questions_ids = report_question_ids(current_user, quiz.id)

        questions = quiz.questions.where.not(id: attempt_questions_ids).order(created_at: :desc)
        {
          question: questions.first,
          has_next_question: questions.length >= POSSIBLE_FOR_NEXT_QUESTION
        }
      end

      def report_question_ids(current_user, quiz_id)
        current_user.reports.
          where(subdomain_quiz_id: quiz_id).
            pluck(:subdomain_question_id)
      end
    end
  end
end