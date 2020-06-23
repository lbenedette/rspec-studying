require 'rails_helper'

RSpec.describe Account, type: :model do
  it '#full_name' do
    account = create(:account)
    expect(account.full_name).to start_with("Sr. ")
  end

  it { expect{create(:account)}.to change{ Account.all.size }.by(1) }
end
