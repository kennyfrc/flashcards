require 'rails_helper'

describe "User" do
  let(:user) { create(:user) }

  describe "#cards" do
    it "user has many cards" do
      expect(user.cards).not_to eq(0)
    end
  end
end
