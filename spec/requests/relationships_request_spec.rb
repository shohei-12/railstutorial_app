require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  context 'not logged in' do
    it 'must not follow' do
      post relationships_path
      expect(Relationship.count).to eq 0
      expect(response).to redirect_to login_path
    end

    it 'must not unfollow' do
      user = create(:user)
      other = create(:other)
      relationship_1 =
        create(:relationship_1, follower_id: user.id, followed_id: other.id)
      delete relationship_path(relationship_1)
      expect(Relationship.count).to eq 1
      expect(response).to redirect_to login_path
    end
  end
end
