# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :accessory_adjustment do
    effective_date "2013-05-21"
    created_by_id 1
    updated_by_id 1
    submitted_by_id 1
    submitted_at "2013-05-21 08:46:18"
    submitted false
    confirmed false
    confirmed_by_id 1
    confirmed_at "2013-05-21 08:46:18"
    approved false
    approved_at "2013-05-21 08:46:18"
    approved_by_id 1
  end
end
