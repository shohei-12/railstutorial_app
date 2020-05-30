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

  describe 'edit and update actions' do
    before { @user = create(:user) }

    context 'not logged in' do
      it 'must not be edited' do
        get edit_user_path(@user)
        expect(response).to redirect_to login_path
      end

      it 'must not be updated' do
        patch user_path(@user), params: { user: attributes_for(:user) }
        expect(response).to redirect_to login_path
      end
    end

    context 'logged in as other user' do
      before do
        @other = create(:other)
        post login_path, params: { session: attributes_for(:other) }
      end

      it 'must not be edited' do
        get edit_user_path(@user)
        expect(response).to redirect_to root_path
      end

      it 'must not be updated' do
        patch user_path(@user), params: { user: attributes_for(:user) }
        expect(response).to redirect_to root_path
      end
    end

    describe 'friendly forwarding' do
      it 'must be redirected to the edit page after logging in' do
        get edit_user_path(@user)
        expect(response).to redirect_to login_path
        post login_path, params: { session: attributes_for(:user) }
        expect(response).to redirect_to edit_user_path(@user)
        expect(session[:forwarding_url]).to eq nil
      end
    end
  end
end
