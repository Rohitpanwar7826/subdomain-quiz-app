# Subdomain::Quizzes::GetQuizzes.call(status)
module Subdomain
  module Quizzes
    class GetQuizzes < Base
      class << self
        POSSIBLE_STATES = {
          "pending"=> Stats::Pending,
          "today"=> Stats::Today,
          "complete"=> Stats::Complete,
        }.freeze
        
        def call(status)
          process(status)
        end
        
        private
        def process(status)
          service = POSSIBLE_STATES[status]
          raise "Unknown stats #{status}, POSSIBLE_STATS [PEDING, IN-PROGRESS, COMPLETE]" if !service.present?
          service.call
        end
      end
    end  
  end
end