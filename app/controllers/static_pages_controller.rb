class StaticPagesController < ApplicationController


  def home
    if logged_in?
      redirect_to :main_menu
    end
  end

  def main_menu
  end
  
end
