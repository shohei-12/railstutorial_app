require 'rails_helper'

RSpec.describe 'Microposts', type: :request do
  context 'not logged in' do
    before do
      @user = create(:user)
      @orange = create(:orange, user_id: @user.id)
    end
    it 'must not be created' do
      post microposts_path, params: { micropost: { content: 'Lorem ipsum' } }
      expect(Micropost.count).to eq 1
      expect(response).to redirect_to login_path
    end

    it 'must not be deleted' do
      delete micropost_path(@orange)
      expect(Micropost.count).to eq 1
      expect(response).to redirect_to login_path
    end
  end
  context 'logged in as wrong user' do
    it 'must not be deleted' do
      user = create(:user)
      other = create(:other)
      orange = create(:orange, user_id: other.id)
      post login_path, params: { session: attributes_for(:user) }
      delete micropost_path(orange)
      expect(Micropost.count).to eq 1
      expect(response).to redirect_to root_path
    end
  end
end
