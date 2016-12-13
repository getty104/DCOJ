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
    @posts = Post.all.order("created_at DESC")
  end
end
