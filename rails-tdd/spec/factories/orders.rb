FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Order ##{n}" }
    # account
    association :account, factory: :account
  end
end
