class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
  end

  def show
  end

  def create
    @card = Card.new(article_params)

    @card.save
    redirect_to @card
  end

  private

  def article_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end
end
