module Subdomain
  class PassFail < Base
    class << self
      PASS_FAIL_STATUS = { pass: 'passed', fail: 'fail' }
      def call(total, user_total)
        passing_marks = minimum_mark_to_pass_student(total)
        user_total >= passing_marks ? PASS_FAIL_STATUS[:pass] : PASS_FAIL_STATUS[:fail]
      end

      def minimum_mark_to_pass_student(total)
        total/3
      end
    end
  end
end