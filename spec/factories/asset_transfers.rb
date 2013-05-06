# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset_transfer do
    asset_id 1
    effective_date "2013-05-02"
    created_by_id 1
    updated_by_id 1
    confirmed_by_id 1
    confirmed_at "2013-05-02 11:35:11"
    approved_at "2013-05-02 11:35:11"
    approved_by_id 1
    rejected_at "2013-05-02 11:35:11"
    rejected_by_id 1
    submitted_by_id 1
    submitted_at 1
    published false
    published_at "2013-05-02 11:35:11"
    document_status "MyString"
  end
end
