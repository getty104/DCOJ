require 'test_helper'

class InquiriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get inquiries_index_url
    assert_response :success
  end

  test "should get confirm" do
    get inquiries_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get inquiries_thanks_url
    assert_response :success
  end

end
