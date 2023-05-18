require "test_helper"

class Admin::SupplementalQuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_supplemental_questions_destroy_url
    assert_response :success
  end
end
