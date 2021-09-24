require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  let(:admin) { create(:admin) }

  describe 'GET /index' do
    it 'returns the index page' do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  it 'signs admin in' do
    sign_in admin
    get root_path
    expect(response).to have_http_status(:ok)
  end

  it 'signs admin out' do
    sign_out admin
    get root_path
    expect(response).to have_http_status(:ok)
  end

  it 'lets admin open admin settings' do
    sign_in admin
    get admins_trader_settings_path
    expect(response).to have_http_status(:ok)
  end

  it 'lets admin approve pending users' do
    sign_in admin
    get admins_approvals_path
    expect(response).to have_http_status(:ok)
  end
end
