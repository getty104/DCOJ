class StaticPagesController < ApplicationController


  def home
      redirect_to :main_menu if user_signed_in?
  end

  def main_menu
   authenticate_user!
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
    @created_users = User.order("created_question_number DESC")
    @solved_users = User.order("solved_question_number DESC")
  end
end
