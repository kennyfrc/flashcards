class HomeController < ApplicationController
  def welcome
    @card = Card.random_card
  end
end
