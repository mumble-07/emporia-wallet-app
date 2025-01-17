require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  describe 'create users' do
    let(:valid_params) { { user: { email: 'test_user@test.com', password: 'test12345', full_name: 'test_user', username: 'test_user' } } }
    # create user

    it 'creates a new user' do
      expect { post admins_add_user_path, params: valid_params }.to change(User, :count).by(+1)
    end

    it 'redirects after creation' do
      post admins_add_user_path, params: valid_params
      expect(response).to have_http_status :redirect
    end
  end
end
