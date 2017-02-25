class HomeController < ApplicationController
  def welcome
    @card = Card.random
  end

  def check
    @card = Card.find(params_ans_id)

    if params_ans.casecmp?(@card.original_text)
      flash[:notice] = "Right!"
      @card.add_three_days
    else
      flash[:error] = "Wrong!"
    end
  end

  private

  def params_ans
    params[:card][:original_text]
  end

  def params_ans_id
    params[:card][:hidden_id]
  end
end
