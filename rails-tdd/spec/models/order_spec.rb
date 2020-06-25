require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'FactoryBot' do
    it 'using sequence in order.description' do
      first_order = create(:order)
      second_order = create(:order)
      
      order_number = first_order.description[/(\d+)/].to_i

      expect(second_order.description).to eq("Order ##{order_number + 1}")
    end

    it '#account' do
      order = create(:order)
      
      expect(order.account).to be_kind_of(Account)
      expect(order.account.vip).to eq(false)
    end

    it 'account is vip' do
      account = create(:account_vip)
      order = create(:order, account: account)
      
      expect(order.account).to be_kind_of(Account)
      expect(order.account.vip).to eq(true)
    end

    it '#create_list' do
      orders = create_list(:order, 3)
      
      expect(orders.count).to eq(3)
    end
  end
end
