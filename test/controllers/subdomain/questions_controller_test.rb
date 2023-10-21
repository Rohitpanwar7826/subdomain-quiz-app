require "test_helper"

class Subdomain::QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subdomain_questions_new_url
    assert_response :success
  end

  test "should get create" do
    get subdomain_questions_create_url
    assert_response :success
  end
end
