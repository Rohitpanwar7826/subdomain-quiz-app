module Subdomain
  class MarkQuizEnrollmentComplete < Base
    class << self
      def call(current_user, quiz, error_tracker= ErrorTracker.new)
        begin
          result = process(current_user, quiz, error_tracker)
        rescue => e
          error_tracker.add_error(e.message)
        end
        OperationBuilder.call(result, error_tracker)    
      end

      def process(current_user, quiz, error_tracker)
        quiz_enrollment = find_quiz_enrollments(current_user, quiz)
        quiz_enrollment.complete!
      end

      def find_quiz_enrollments(current_user, quiz)
        current_user.quiz_enrollments.find_by(subdomain_quiz_id: quiz.id)
      end
    end
  end
end