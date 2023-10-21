require "test_helper"

class Subdomain::QuizzesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subdomain_quizzes_new_url
    assert_response :success
  end

  test "should get create" do
    get subdomain_quizzes_create_url
    assert_response :success
  end
end
