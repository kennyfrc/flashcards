FactoryGirl.define do
  factory :card do
    original_text "How are you?"
    translated_text "Kamusta?"
    review_date DateTime.now.getutc
    user_id 1
  end
end
