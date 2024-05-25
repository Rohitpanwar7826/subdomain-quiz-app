# Subdomain::Results::GetResultBuilder.call
module Subdomain
  module Results
    class GetResultBuilder < Base
      class << self
        def call(current_user)
          process(current_user)
        end

        def process(current_user)
          total_result_count = current_user.results.count
          total_passed_result_count = current_user.results.passed.count
          {
            total_result_count: total_result_count*100,
            total_passed_result_count: total_passed_result_count*100,
          }
        end
      end
    end
  end
end
