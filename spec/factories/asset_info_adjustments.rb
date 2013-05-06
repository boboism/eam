# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset_info_adjustment do
    asset_id 1
    effective_date "2013-05-02"
    asset_name_from "MyString"
    asset_name_to "MyString"
    brand_from "MyString"
    brand_to "MyString"
    model_from "MyString"
    model_to "MyString"
    serial_no_from "MyString"
    serial_no_to "MyString"
    is_tariff_free_from false
    is_tariff_free_to false
    is_specific_fund_from false
    is_specific_fund_to false
    tax_preference_id_from 1
    tax_preference_id_to 1
    is_vat_free_from false
    is_vat_free_to false
    vat_from "9.99"
    vat_to "9.99"
    vat_rate_from "9.99"
    vat_rate_to "9.99"
    created_by_id 1
    updated_by_id 1
    confirmed_by_id 1
    confirmed_at "2013-05-02 11:28:38"
    approved_at "2013-05-02 11:28:38"
    approved_by_id 1
    rejected_at "2013-05-02 11:28:38"
    rejected_by_id 1
    submitted_at "2013-05-02 11:28:38"
    submitted_by_id 1
  end
end
