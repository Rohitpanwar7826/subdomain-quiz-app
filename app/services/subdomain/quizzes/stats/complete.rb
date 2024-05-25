module Subdomain
  module Quizzes
    module Stats
      class Complete < Base
        class << self
          def call
            process
          end

          def process
            quizzes = Subdomain::Quiz.complete.order(created_at: :desc)
            service_builder(quizzes.count, quizzes.first(5))
          end
        end
      end
    end
  end
end