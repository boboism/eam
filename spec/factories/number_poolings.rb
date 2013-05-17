# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :number_pooling do
    type ""
    serial "MyString"
    status 1
    owned_by_id 1
  end
end
