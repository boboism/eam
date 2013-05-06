# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset_cost_adjustment do
    asset_id 1
    effective_date "2013-05-02"
    original_cost_from "9.99"
    original_cost_to "9.99"
    salvage_from "9.99"
    salvage_to "9.99"
    salvage_rate_from "9.99"
    salvage_rate_to "9.99"
    created_by_id 1
    updated_by_id 1
    confirmed_by_id 1
    confirmed_at "2013-05-02 11:22:46"
    approved_by_id 1
    approved_at "2013-05-02 11:22:46"
    rejected_by_id 1
    rejected_at "2013-05-02 11:22:46"
    published false
    published_at "2013-05-02 11:22:46"
  end
end
