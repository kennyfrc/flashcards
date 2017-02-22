class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
  end

  def show
    @card = Card.find(params[:id])
  end

  def create
    @card = Card.new(article_params)

    if @card.save
      flash[:notice] = "Card successfully created!"
      redirect_to @card
    else
      flash[:error] = "Please complete the fields or use a valid translation."
      render action: "new"
    end
  end

  private

  def article_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end
end
