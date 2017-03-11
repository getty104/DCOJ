class RankingsController < ApplicationController
  def rate_ranking
  	@users = User.select(:name,:rate, :rate_rank).order("rate_rank").page(params[:page]).per(20)
  end
end
