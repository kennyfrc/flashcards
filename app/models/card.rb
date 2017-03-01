class Card < ApplicationRecord
  belongs_to :user
  validates :original_text, :translated_text, presence: true
  validate :texts_are_not_the_same?

  before_create :default_review_algorithm

  REVIEW_TIME_GAP = 3

  def self.random
    due_today.order("RANDOM()").first
  end

  def self.due_today
    where("review_date <= ?", DateTime.now.to_date)
  end

  def update_review_date
    new_review_date = review_date + REVIEW_TIME_GAP
    update(review_date: new_review_date)
  end

  def right_translation?(answer)
    sanitized_answer = answer.gsub(/[\s,\W+]/, '')
    sanitized_orig_text = original_text.gsub(/[\s,\W+]/, '')
    sanitized_answer.casecmp?(sanitized_orig_text)
  end

  protected

  def default_review_algorithm
    self.review_date = DateTime.now + REVIEW_TIME_GAP if review_date.nil?
  end

  def texts_are_not_the_same?
    errors.add(:translated_text, "Please Ensure that the texts are not the same!") if original_text.casecmp?(translated_text)
  end
end
