# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset_allocation do
    asset_id 1
    management_department_id 1
    cost_center_id 1
    construction_period_id 1
    specific_investment_id 1
    quantity "9.99"
    enabled false
    enabled_at "2013-05-02 11:16:54"
    created_by_id 1
    updated_by_id 1
  end
end
