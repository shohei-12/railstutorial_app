require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject { response }

  describe 'GET /signup' do
    it 'show new page' do
      get signup_path
      is_expected.to have_http_status(:success)
      expect(response.body).to include full_title('Sign up')
    end

    it 'log in after user signup' do
      post users_path, params: { user: attributes_for(:user) }
      is_expected.to redirect_to user_path(User.last)
      is_expected.to have_http_status 302
      expect(is_logged_in?).to be_truthy
    end
  end

  describe 'edit and update actions' do
    before { @user = create(:user) }

    context 'not logged in' do
      it 'must not be edited' do
        get edit_user_path(@user)
        is_expected.to redirect_to login_path
      end

      it 'must not be updated' do
        patch user_path(@user), params: { user: attributes_for(:user) }
        is_expected.to redirect_to login_path
      end
    end

    context 'logged in as other user' do
      before do
        @other = create(:other)
        post login_path, params: { session: attributes_for(:other) }
      end

      it 'must not be edited' do
        get edit_user_path(@user)
        is_expected.to redirect_to root_path
      end

      it 'must not be updated' do
        patch user_path(@user), params: { user: attributes_for(:user) }
        is_expected.to redirect_to root_path
      end
    end

    describe 'friendly forwarding' do
      it 'must be redirected to the edit page after logging in' do
        get edit_user_path(@user)
        is_expected.to redirect_to login_path
        post login_path, params: { session: attributes_for(:user) }
        is_expected.to redirect_to edit_user_path(@user)
        expect(session[:forwarding_url]).to eq nil
      end
    end
  end

  describe 'destroy action' do
    before do
      @user = create(:user)
      @other = create(:other)
    end

    it 'must not delete user if not logged in' do
      delete user_path(@other)
      is_expected.to redirect_to login_path
    end

    it 'must not delete user if not an administrator' do
      post login_path, params: { session: attributes_for(:other) }
      delete user_path(@user)
      is_expected.to redirect_to root_path
    end
  end

  it 'must not allow the admin attribute to be edited via the web' do
    @other = create(:other)
    post login_path, params: { session: attributes_for(:other) }
    expect(@other.admin?).to be_falsey
    patch user_path(@other), params: { user: { admin: true } }
    expect(@other.reload.admin?).to be_falsey
  end

  describe 'following and followers actions' do
    before { @other = create(:other) }

    it 'must not display a follow page if not logged in' do
      get following_user_path(@other)
      is_expected.to redirect_to login_path
    end

    it 'must not display a follower page if not logged in' do
      get followers_user_path(@other)
      is_expected.to redirect_to login_path
    end
  end
end
