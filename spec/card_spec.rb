require 'rails_helper'

describe Card do
  before do
    @card = Card.create(original_text: "How are you?", translated_text: "Kamusta?", review_date: DateTime.new(2017, 2, 24))
  end

  describe "card class methods" do
    describe "self.due_today" do
      it "should know that 1 card is due today" do
        Card.due_today.count.should == 1
      end
    end

    describe "self.random" do
      it "should return the exact same card" do
        Card.random.object_id == @card.object_id
      end
    end

    describe "self.random" do
      it "returns nil if it's empty" do
        Card.none.random.should.nil?
      end
    end
  end

  describe "card instance methods" do
    describe "#update_review_date" do
      it "adds three days" do
        @card.update_review_date
        expect(@card.review_date).to eq(DateTime.new(2017, 2, 27))
      end
    end

    describe "right_translation?" do
      it "return true if the correct translation" do
        expect(@card.right_translation?("How are you?")).to eq(true)
      end

      it "return true if the user used random cases" do
        expect(@card.right_translation?("HoW aRe yoU?")).to eq(true)
      end

      it "return true if the user forgot to add proper punctuation" do
        expect(@card.right_translation?("How are you")).to eq(true)
      end

      it "return true if the user messed up spacing" do
        expect(@card.right_translation?("   How are you?  ")).to eq(true)
      end
    end
  end
end
