require "test_helper"

class QuizsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get quizs_index_url
    assert_response :success
  end

  test "should get new" do
    get quizs_new_url
    assert_response :success
  end

  test "should get show" do
    get quizs_show_url
    assert_response :success
  end
end
