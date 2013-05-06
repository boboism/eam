# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset do
    asset_no "MyString"
    asset_name "MyString"
    brand "MyString"
    model "MyString"
    serial_no "MyString"
    category_id 1
    sub_category_id 1
    original_cost "9.99"
    salvage "9.99"
    salvage_rate "9.99"
    activated_by_id 1
    activated_at "2013-05-02 11:15:27"
    activated false
    accepted_by_id 1
    accepted false
    accepted_at "2013-05-02 11:15:27"
    is_tariff_free false
    is_specific_fund false
    tax_preference_id 1
    is_vat_free false
    vat "9.99"
    vat_rate "9.99"
    created_by_id 1
    updated_by_id 1
    published false
    published_at "2013-05-02 11:15:27"
  end
end
