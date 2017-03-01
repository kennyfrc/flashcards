require 'rails_helper'
require 'support/factory_girl.rb'

describe "the checking process" do
  let!(:card_test) { create(:card) }

  it "confirms that the checking flow is working" do
    visit root_path
    fill_in "card_original_text", with: "How are you?"
    click_button "Check"
    expect(page).to have_content "Right!"
  end

  it "confirms that the checking flow is working" do
    visit root_path
    fill_in "card_original_text", with: "Hwo are you?"
    click_button "Check"
    expect(page).to have_content "Wrong!"
  end
end
