# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset_categorization_item do
    asset_name "MyString"
    quantity "9.99"
    amount "9.99"
    conversion_rate "9.99"
    supplier "MyString"
    contract_no "MyString"
    usage "MyString"
    remark "MyString"
    categorizing_asset_id 1
  end
end
