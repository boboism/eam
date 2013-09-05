# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :model_relationship do
    refer_from_id 1
    refer_from_type "MyString"
    refer_from_status 1
    refer_to_id 1
    refer_to_type "MyString"
    refer_to_status 1
    type ""
  end
end
