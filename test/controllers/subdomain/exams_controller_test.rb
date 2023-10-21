require "test_helper"

class Subdomain::ExamsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subdomain_exams_index_url
    assert_response :success
  end
end
