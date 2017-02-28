require 'rails_helper'

describe Card do
  let!(:card) { create(:card) }

  describe "card class methods" do
    describe "self.due_today" do
      it "should know that 1 card is due today" do
        expect(Card.due_today.count).to eq(1)
      end
    end
  end

  describe "card instance methods" do
    describe "#update_review_date" do
      it "adds three days" do
        card.update_review_date
        expect(card.review_date.to_date).to eq(3.days.from_now.getutc.to_date)
      end
    end

    describe "right_translation?" do
      it "return true if the correct translation" do
        expect(card.right_translation?("How are you?")).to eq(true)
      end

      it "return true if the user used random cases" do
        expect(card.right_translation?("HoW aRe yoU?")).to eq(true)
      end

      it "return true if the user forgot to add proper punctuation" do
        expect(card.right_translation?("How are you")).to eq(true)
      end

      it "return true if the user messed up spacing" do
        expect(card.right_translation?("   How are you?  ")).to eq(true)
      end

      it "return false if the user misspelled" do
        expect(card.right_translation?("How are yuo?")).to eq(false)
      end

      it "return false if the user gave the wrong answer" do
        expect(card.right_translation?("Hello")).to eq(false)
      end
    end
  end
end
