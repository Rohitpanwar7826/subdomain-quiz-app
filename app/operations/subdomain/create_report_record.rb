module Subdomain
  class CreateReportRecord < Base
    class << self
      def call(quiz, question, current_user, given_answer, error_tracker= ErrorTracker.new)
        begin
          result = process(quiz, question, current_user, given_answer, error_tracker)
        rescue => e
          error_tracker.add_error(e.message)
        end
        OperationBuilder.call(result, error_tracker)
      end

      def process(quiz, question, current_user, given_answer, error_tracker)
        create_record_for_report(quiz, question, current_user, given_answer, error_tracker)
      end
      
      def create_record_for_report(quiz, question, current_user, given_answer, error_tracker)
        return if quiz.reports.find_by(find_report_params(question, current_user)).present?

        report = quiz.reports.new(build_report_params(question, current_user, given_answer))

        unless report.save
          error_tracker.add_error(report.errors.full_messages.join(', '))
        end
        report
      end

      def build_report_params(question, current_user, given_answer)
        {
          subdomain_question_id: question.id, 
          subdomain_user_id: current_user.id,
          weight: question.weight,
          result: {
            given_answer: given_answer,
            correct_answer: question.correct
          },
          is_correct: question.correct == given_answer
        }
      end
      
      def find_report_params(question, current_user)
        {
          subdomain_question_id: question.id, 
          subdomain_user_id: current_user.id
        }
      end
    end
  end  
end


# t.uuid "subdomain_quiz_id", null: false
# t.uuid "subdomain_question_id", null: false
# t.uuid "subdomain_user_id", null: false
# t.string "weight"
# t.json "result"
# t.boolean "is_correct"