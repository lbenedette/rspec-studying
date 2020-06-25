require 'rails_helper'

RSpec.describe Account, type: :model do
  # build: create a instance
  # create: create a row in the database
  # attributes_for: return only the values

  it { expect{create(:account)}.to change{ Account.all.size }.by(1) }

  it '#full_name' do
    account = create(:account, name: "Bilbo Baggins")
    expect(account.full_name).to eq("Sr. Bilbo Baggins")
  end

  it '#email' do
    account = create(:account, name: "Bilbo Baggins")
    expect(account.email).to eq("bilbo.baggins@example.com")
  end

  context 'FactoryBot inheritance' do
    it 'factory account_default' do
      account = create(:account)
      expect(account.vip).to eq(false)
      expect(account.days_to_pay).to eq(15)
    end
  
    it 'factory account_vip' do
      account = create(:account_vip)
      expect(account.vip).to eq(true)
      expect(account.days_to_pay).to eq(30)
    end
  end

  context 'FactoryBot attributes_for' do
    it 'getting only the values' do
      attributes = attributes_for(:account, name: "Gandalf")
      account = Account.create(attributes)
      expect(account.name).to eq("Gandalf")
    end
  end

  context 'FactoryBot transient attribute' do
    it 'transient attributes are \'invisible\'' do
      attributes = attributes_for(:account)
      expect(attributes).not_to include(:upcased)
    end

    # after(:build) : after create instance with build or create
    # before(:create) : before save the instance
    # after(:create) : after save the instance
    it 'capitalize name after create' do
      account = create(:account, name: "Gandalf", upcased: true)
      expect(account.name).to eq("GANDALF")
    end
  end

  context 'FactoryBot traits' do
    it 'get a beginner vip account' do
      account = create(:account_vip_beginner)
      expect(account.vip).to eq(true)
      expect(account.level).to eq("beginner")
    end

    it 'get a expert account' do
      account = create(:account, :expert)
      expect(account.vip).to eq(false)
      expect(account.level).to eq("expert")
    end
  end

  context 'FactoryBot has_many relationship' do
    it 'account without orders' do
      account = create(:account)
      expect(account.orders.count).to eq(0)
    end

    it 'trait with_orders' do
      account = create(:account, :with_orders)
      expect(account.orders.count).to eq(3)
    end
  end
end
