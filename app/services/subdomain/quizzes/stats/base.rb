module Subdomain
  module Quizzes
    module Stats
      class Base
        class << self
          def service_builder(count, quizzes)
            {
              count: count,
              quizzes: quizzes,
            }
          end
        end
      end
    end
  end
end