require 'test_helper'

class TestCasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test_case = test_cases(:one)
  end

  test "should get index" do
    get test_cases_url
    assert_response :success
  end

  test "should get new" do
    get new_test_case_url
    assert_response :success
  end

  test "should create test_case" do
    assert_difference('TestCase.count') do
      post test_cases_url, params: { test_case: { case: @test_case.case } }
    end

    assert_redirected_to test_case_url(TestCase.last)
  end

  test "should show test_case" do
    get test_case_url(@test_case)
    assert_response :success
  end

  test "should get edit" do
    get edit_test_case_url(@test_case)
    assert_response :success
  end

  test "should update test_case" do
    patch test_case_url(@test_case), params: { test_case: { case: @test_case.case } }
    assert_redirected_to test_case_url(@test_case)
  end

  test "should destroy test_case" do
    assert_difference('TestCase.count', -1) do
      delete test_case_url(@test_case)
    end

    assert_redirected_to test_cases_url
  end
end
