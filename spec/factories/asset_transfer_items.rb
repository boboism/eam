# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset_transfer_item do
    type ""
    asset_transfer_id 1
    asset_allocation_id 1
    management_department_id 1
    cost_center_id 1
    construction_period_id 1
    specific_investment_id 1
    quantity "9.99"
    created_by_id 1
    updated_by_id 1
  end
end
