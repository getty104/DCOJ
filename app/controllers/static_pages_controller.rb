class StaticPagesController < ApplicationController


  def home
    if logged_in?
      redirect_to :main_menu
    end
  end

  def main_menu
    if !logged_in?
      redirect_to :home
    end
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
  end
end
