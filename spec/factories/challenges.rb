FactoryGirl.define do
  factory :challenge do
    daily false
    weekly false
    item_type 0
    operation_type 0
    greater_than 10
    less_than 2
    available true
    creator_id 1
  end

end
