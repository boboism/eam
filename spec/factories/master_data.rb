# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :master_datum, :class => 'MasterData' do
    code "MyString"
    name "MyString"
    description "MyString"
    parent_id 1
    type ""
  end
end
