require "test_helper"

class Subdomain::EnrollStudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subdomain_enroll_students_index_url
    assert_response :success
  end

  test "should get create" do
    get subdomain_enroll_students_create_url
    assert_response :success
  end
end
