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
    @questions = Question.all.order(:id)
  end
  
end
