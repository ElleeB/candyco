FactoryBot.define do
  factory :order do
    warehouse_id { 1 }
    total_value { "9.99" }
    status { 1 }
  end
end
