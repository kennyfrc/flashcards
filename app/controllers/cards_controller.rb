class CardsController < ApplicationController
  def index
    @cards = current_user.cards
  end

  def new
    @card = Card.new
  end

  def show
    @card = Card.find(params[:id])
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      flash[:notice] = "Card successfully created!"
      redirect_to @card
    else
      flash[:error] = "Please complete the fields or ensure that you're not using the same text."
      render 'new'
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(card_params)
      flash[:notice] = "Card successfully updated!"
      redirect_to @card
    else
      flash[:error] = "Please complete the fields or ensure that you're not using the same text."
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])

    @card.destroy
    flash[:notice] = "Card successfully deleted!"
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id)
  end
end
