# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :model_relationship do
    refer_id_from 1
    refer_id_to 1
    created_by_id 1
    updated_by_id 1
  end
end
