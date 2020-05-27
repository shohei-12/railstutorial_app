require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /new' do
    before { get login_path }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    describe 'log in and log out' do
      let(:user) { create(:user) }
      before do
        post login_path,
             params: { session: { email: user.email, password: user.password } }
      end

      it 'log in' do
        expect(response).to redirect_to user_path(user)
        expect(is_logged_in?).to be_truthy
      end

      it 'log out' do
        delete logout_path
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsey

        # Simulate a user clicking logout in a second window
        delete logout_path
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsey
      end
    end
  end
end
