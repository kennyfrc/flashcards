class Card < ApplicationRecord  
  validates :original_text, :translated_text, :review_date, presence: true
  validate :texts_are_not_the_same?

  before_validation :default_review_algorithm

  REVIEW_TIME_GAP = 3.freeze

  protected

  def default_review_algorithm
    if review_date.nil?
      self.review_date = DateTime.now + REVIEW_TIME_GAP
    end
  end

  def texts_are_not_the_same?
    if !(original_text.downcase != translated_text.downcase)
      errors.add(:translated_text, "Please Ensure that the texts are not the same!")
    end
  end
end
