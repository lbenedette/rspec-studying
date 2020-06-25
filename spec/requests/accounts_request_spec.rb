require 'rails_helper'

RSpec.describe "/accounts", type: :request do
  let(:valid_attributes) {
    attributes_for(:account)
  }

  describe "GET /index" do
    it 'responds successfully' do
      get accounts_url, as: :json
      expect(response).to be_successful
    end

    it 'responds a 200 OK' do
      get accounts_url, as: :json
      expect(response).to have_http_status 200
    end
  end

  describe "GET /show" do
    before do
      @account = create(:account)
      @user = create(:user)
    end

    it 'responds a 200 OK' do
      sign_in @user
      get account_url(@account), as: :json
      expect(response).to have_http_status 200
    end

    it 'responds a 401 Unauthorized' do
      get account_url(@account), as: :json
      expect(response).to have_http_status 401
    end
  end

  describe "POST /create" do
    before do
      @user = create(:user)
    end

    it 'creates a new Account' do
      sign_in @user
      expect {
        post accounts_url, params: { account: valid_attributes }, as: :json
      }.to change(Account, :count).by(1)
    end
  end
end
