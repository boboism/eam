# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset_categorization do
    categorize_type 1
    created_by_id 1
    updated_by_id 1
    submitted_by_id 1
    submitted_at "2013-05-16 08:57:17"
    confirmed_by_id 1
    confirmed_at "2013-05-16 08:57:17"
    approved_by_id 1
    approved_at "2013-05-16 08:57:17"
  end
end
