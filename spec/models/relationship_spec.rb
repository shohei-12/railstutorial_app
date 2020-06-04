require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it 'must be valid' do
    relationship =
      Relationship.new(
        follower_id: create(:user).id, followed_id: create(:other).id
      )
    expect(relationship).to be_valid
  end

  describe 'validations' do
    subject { Relationship.new }

    describe 'follower_id' do
      it { is_expected.to validate_presence_of(:follower_id) }
    end

    describe 'followed_id' do
      it { is_expected.to validate_presence_of(:followed_id) }
    end
  end
end
