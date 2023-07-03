require "test_helper"

class Public::LearningRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_learning_records_index_url
    assert_response :success
  end

  test "should get new" do
    get public_learning_records_new_url
    assert_response :success
  end

  test "should get create" do
    get public_learning_records_create_url
    assert_response :success
  end

  test "should get show" do
    get public_learning_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_learning_records_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_learning_records_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_learning_records_destroy_url
    assert_response :success
  end
end
