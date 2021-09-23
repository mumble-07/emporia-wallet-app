require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns the index page' do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end
end
