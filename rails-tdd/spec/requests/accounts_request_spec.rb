require 'rails_helper'

RSpec.describe "/accounts", type: :request do
  let(:valid_attributes) {
    attributes_for(:account)
  }

  let(:account_mock) {
    double("account")
  }

  describe "as a guest user" do
    context "GET /index" do
      it 'should get all accounts MOCK' do
        expected_account_list = build_list(:account, 1, name: "Bilbo Baggins")
        expect(Account).to receive(:all).and_return(expected_account_list)

        get accounts_url, as: :json

        parsed_body = JSON.parse(response.body)
        expect(response).to have_http_status 200
        expect(parsed_body.count).to eq(1)
        expect(parsed_body[0]["name"]).to eq("Bilbo Baggins")
      end

      it 'should get all accounts MODEL' do
        get accounts_url, as: :json

        expect(response).to have_http_status 200
        expect(response.body).to include_json([
          id: /\d/,
          name: (be_kind_of String),
          email: (be_kind_of String)
        ])
      end
    end

    context "GET /show" do
      it 'responds a 401 Unauthorized' do
        get '/accounts/1', as: :json
        expect(response).to have_http_status 401
      end
    end
  end

  describe "as a logged user" do
    before do
      @account = create(:account)
      @user = create(:user)
    end

    context "GET /show" do
      it 'should return an account' do
        sign_in @user

        get account_url(@account), as: :json
        
        expect(response).to have_http_status 200
        expect(response.body).to include_json(
          id: @account.id,
          name: @account.name
        )
      end
    end

    context "POST /create" do
      it 'shoudl creates a new Account' do
        sign_in @user

        expect {
          post accounts_url, params: { account: valid_attributes }, as: :json
        }.to change(Account, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end
end
