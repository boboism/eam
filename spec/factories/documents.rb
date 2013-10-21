# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document do
    description "MyText"
    documentable_id 1
    documentable_type "MyString"
    type ""
    status "MyString"
  end
end
