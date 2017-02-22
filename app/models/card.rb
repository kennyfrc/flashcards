class Card < ApplicationRecord
  validates :original_text, :translated_text, presence: true
  validate :texts_are_not_the_same?

  before_create :default_review_algorithm

  REVIEW_TIME_GAP = 3

  protected

  def default_review_algorithm
    self.review_date = DateTime.now + REVIEW_TIME_GAP if review_date.nil?
  end

  def texts_are_not_the_same?
    errors.add(:translated_text, "Please Ensure that the texts are not the same!") if original_text.casecmp?(translated_text)
  end
end
