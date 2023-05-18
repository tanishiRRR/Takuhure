require "test_helper"

class Public::QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_questions_create_url
    assert_response :success
  end

  test "should get new" do
    get public_questions_new_url
    assert_response :success
  end

  test "should get destroy" do
    get public_questions_destroy_url
    assert_response :success
  end
end
