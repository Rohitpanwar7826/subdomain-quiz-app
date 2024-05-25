module Subdomain::ResultsHelper
  def pass_or_fail(result)
    generated_span = result.pass_or_fail == "passed" ? "<span class='bg-success p-1 text-white text-center'>PASS</span>" : "<span class='bg-danger p-1 text-white text-center'>FAIL</span>"
    generated_span.html_safe
  end

  def generate_correct_answer(correct)
    generated_span = correct ? "<span class='bg-success p-1 text-white text-center'>YES</span>" : "<span class='bg-danger p-1 text-white text-center'>NO</span>"
    generated_span.html_safe
  end
end
