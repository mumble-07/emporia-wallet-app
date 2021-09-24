require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:user_pending) { create(:user_pending) }

  describe 'User sign in and log out' do
    it 'returns the index page' do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  it 'signs user in' do
    sign_in user
    get markets_path
    expect(response).to have_http_status(:ok)
  end

  it 'signs user out' do
    sign_out user
    get root_path
    expect(response).to have_http_status(:ok)
  end

  it 'says user approval is still pending' do
    sign_in user_pending
    get markets_path
    expect(response).not_to render_template(:index)
  end
end
