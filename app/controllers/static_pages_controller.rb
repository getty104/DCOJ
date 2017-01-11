class StaticPagesController < ApplicationController


  def home
      redirect_to :main_menu if user_signed_in?
  end

  def main_menu
   authenticate_user!
    @posts = Post.order("created_at DESC").includes(:user).includes(:question).page(params[:page]).per(10)
    @created_users = User.all.select(:name, :created_question_number).limit(5).order('created_question_number DESC')
    @solved_users = User.all.select(:name, :solved_question_number).limit(5).order('solved_question_number DESC')
  end
end
