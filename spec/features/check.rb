require 'rails_helper'
require 'support/factory_girl.rb'

describe "the checking process" do
  before do
    @card = create(:card)  
  end

  it "confirms that the checking flow is working" do
    visit root_path
    fill_in "card_original_text", with: "How are you?"
    click_button "Check"
    expect(page).to have_content "Right!"
  end
end