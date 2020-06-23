require 'rails_helper'

RSpec.describe Account, type: :model do
  it '#full_name' do
    account = create(:account, name: "Bilbo Baggins")
    expect(account.full_name).to eq("Sr. Bilbo Baggins")
  end

  it { expect{create(:account)}.to change{ Account.all.size }.by(1) }
end
