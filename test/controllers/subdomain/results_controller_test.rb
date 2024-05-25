require "test_helper"

class Subdomain::ResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subdomain_results_index_url
    assert_response :success
  end

  test "should get show" do
    get subdomain_results_show_url
    assert_response :success
  end
end
