module Subdomain
  module Quizzes
    module Stats
      class Pending < Base
        class << self
          def call
            process
          end

          def process
            quizzes = Subdomain::Quiz.soon.order(created_at: :desc)
            service_builder(quizzes.count, quizzes.first(5))
          end
        end
      end
    end
  end
end