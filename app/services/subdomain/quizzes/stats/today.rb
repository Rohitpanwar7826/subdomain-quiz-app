module Subdomain
  module Quizzes
    module Stats
      class Today < Base
        class << self
          def call
            process
          end

          def process
            quizzes = Subdomain::Quiz.soon.order(created_at: :desc)
                      .where(test_date_time: Date.today)
            service_builder(quizzes.count, quizzes.first(5))

            service_builder(0, [])
          end
        end
      end
    end
  end
end