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
    @created_users = User.order("created_question_number DESC")
    @solved_users = User.order("solved_question_number DESC")
  end
end
