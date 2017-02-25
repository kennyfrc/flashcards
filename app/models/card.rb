class Card < ApplicationRecord
  validates :original_text, :translated_text, presence: true
  validate :texts_are_not_the_same?

  before_create :default_review_algorithm

  def self.random
    if due_today.empty?
      nil
    else
      due_today.order("RANDOM()").first
    end
  end

  REVIEW_TIME_GAP = 3

  def check
    translated_text
  end

  def add_three_days
    new_review_date = review_date + REVIEW_TIME_GAP
    update(:review_date => new_review_date)
  end

  protected

  def default_review_algorithm
    self.review_date = DateTime.now + REVIEW_TIME_GAP if review_date.nil?
  end

  def texts_are_not_the_same?
    errors.add(:translated_text, "Please Ensure that the texts are not the same!") if original_text.casecmp?(translated_text)
  end

  def self.due_today
    where("review_date < ?", DateTime.now)
  end
end