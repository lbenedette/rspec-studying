FactoryBot.define do
    factory :account do
        transient do 
            upcased { false }
            quantity_orders { 3 }
        end

        name { Faker::Name.name }
        email { name.downcase.sub(" ", ".") + "@example.com" }
        # sequence(:email) { |n| "email_#{n}@example.com"}
        vip { false }
        days_to_pay { 15 }

        trait :vip do
            vip { true }
            days_to_pay { 30 }
        end

        factory :account_vip, traits: ['vip']

        trait :beginner do
            level { "beginner" }
        end 

        factory :account_vip_beginner, traits: ['vip', 'beginner']

        trait :expert do
            level { "expert" }
        end

        trait :with_orders do
            after(:create) do |account, evaluator|
                create_list(:order, evaluator.quantity_orders, account: account)
            end
        end

        after(:create) do |account, evaluator|
            account.name.upcase! if evaluator.upcased
        end
    end
end