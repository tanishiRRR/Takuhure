require "test_helper"

class Admin::AnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_answers_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_answers_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_answers_destroy_url
    assert_response :success
  end
end
