require 'test_helper'

class ContestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contests_new_url
    assert_response :success
  end

  test "should get create" do
    get contests_create_url
    assert_response :success
  end

  test "should get edit" do
    get contests_edit_url
    assert_response :success
  end

  test "should get update" do
    get contests_update_url
    assert_response :success
  end

  test "should get destroy" do
    get contests_destroy_url
    assert_response :success
  end

end
