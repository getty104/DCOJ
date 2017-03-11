require 'test_helper'

class RankingsControllerTest < ActionDispatch::IntegrationTest
  test "should get rate_ranking" do
    get rankings_rate_ranking_url
    assert_response :success
  end

end
