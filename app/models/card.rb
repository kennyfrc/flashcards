class Card < ApplicationRecord
  REVIEW_TIME_GAP = 3.freeze
  validates :original_text, :translated_text, :review_date, presence: true

  before_validation :default_review_algorithm

  protected

  def default_review_algorithm
    if review_date.nil? #getter method
      self.review_date = DateTime.now + REVIEW_TIME_GAP #setter method
    end
  end
end
