class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
  end

  def show
  end
end
