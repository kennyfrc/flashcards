class Card < ApplicationRecord  
  validates :original_text, :translated_text, :review_date, presence: true  
  validate :text_is_translated?

  before_validation :default_review_algorithm

  REVIEW_TIME_GAP = 3.freeze

  protected

  def default_review_algorithm
    if review_date.nil? #getter method
      self.review_date = DateTime.now + REVIEW_TIME_GAP #setter method
    end
  end

  def text_is_translated?
    if !(original_text.downcase != translated_text.downcase)
      errors.add(:translated_text, "Please translate teh text!")
    end
  end
end
