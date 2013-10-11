# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset do
    asset_no "101001"
    asset_name "Office Building"
    brand "Design Com."
    model "contre"
    serial_no "0001"
    category_id 1
    sub_category_id 1
    original_cost "1000000"
    salvage "1000000"
    salvage_rate "0.05"
    #activated_by_id 1
    #activated_at "2013-05-15 11:15:27"
    activated false
    #accepted_by_id 1
    accepted false
    #accepted_at "2013-05-02 11:15:27"
    is_tariff_free false
    is_specific_fund false
    is_vat_free true
    vat "170000"
    vat_rate "0.17"
    #created_by_id 1
    #updated_by_id 1
    published false
    #published_at "2013-05-02 11:15:27"
  end
end
