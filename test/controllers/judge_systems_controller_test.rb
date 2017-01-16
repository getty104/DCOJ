require 'test_helper'

class JudgeSystemsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@judge_system = judge_systems(:one)
	end

	test "should get index" do
		get judge_systems_url
		assert_response :success
	end

	test "should get new" do
		get new_judge_system_url
		assert_response :success
	end


	test "should create judge_system" do
		assert_difference('JudgeSystem.count') do
			post judge_systems_url, params: { judge_system: { create: @judge_system.create, new: @judge_system.new } }
		end

		assert_redirected_to judge_system_url(JudgeSystem.last)
	end

	test "should show judge_system" do
		get judge_system_url(@judge_system)
		assert_response :success
	end

	test "should get edit" do
		get edit_judge_system_url(@judge_system)
		assert_response :success
	end

	test "should update judge_system" do
		patch judge_system_url(@judge_system), params: { judge_system: { create: @judge_system.create, new: @judge_system.new } }
		assert_redirected_to judge_system_url(@judge_system)
	end

	test "should destroy judge_system" do
		assert_difference('JudgeSystem.count', -1) do
			delete judge_system_url(@judge_system)
		end

		assert_redirected_to judge_systems_url
	end
end
