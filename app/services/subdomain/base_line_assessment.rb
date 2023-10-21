module Subdomain
  class BaseLineAssessment < Base
    class << self
      def call(quiz, current_user_id)
        process(quiz, current_user_id)
      end

      def process(quiz, current_user_id)
        process_for_quiz_enrollment(quiz, current_user_id)
      end

      def process_for_quiz_enrollment(quiz, user_id)
        quiz.base_line_assessment(user_id)
      end
    end
  end  
end