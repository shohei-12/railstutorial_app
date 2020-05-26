require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /signup' do
    it 'show new page' do
      get signup_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include full_title('Sign up')
    end

    it 'Log in after user signup' do
      post users_path, params: { user: attributes_for(:user) }
      expect(response).to redirect_to user_path(User.last)
      expect(response).to have_http_status 302
      expect(is_logged_in?).to be_truthy
    end
  end
end
