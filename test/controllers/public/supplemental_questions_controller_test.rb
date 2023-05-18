require "test_helper"

class Public::SupplementalQuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_supplemental_questions_create_url
    assert_response :success
  end

  test "should get new" do
    get public_supplemental_questions_new_url
    assert_response :success
  end

  test "should get destroy" do
    get public_supplemental_questions_destroy_url
    assert_response :success
  end
end
