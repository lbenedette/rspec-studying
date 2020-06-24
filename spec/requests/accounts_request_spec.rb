require 'rails_helper'

RSpec.describe "/accounts", type: :request do
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
end
