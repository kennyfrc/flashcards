class HomeController < ApplicationController
  def welcome
    @card = Card.random
  end

  def check
    @card = Card.find(params[:card][:hidden_id])
    if @card.right_translation?(params[:card][:original_text])
      flash[:notice] = "Right!"
      @card.update_review_date
    else
      flash[:error] = "Wrong! (Or ensure your spelling is correct)"
    end
  end
end
