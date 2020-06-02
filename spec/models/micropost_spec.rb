require 'rails_helper'

RSpec.describe Micropost, type: :model do
  it 'must be valid' do
    @user = create(:user)
    @micropost = @user.microposts.build(content: 'Lorem ipsum')
    expect(@micropost).to be_valid
  end

  it 'line up in descending order' do
    user = create(:user)
    cat_video = create(:cat_video, user_id: user.id)
    orange = create(:orange, user_id: user.id)
    most_recent = create(:most_recent, user_id: user.id)
    expect(most_recent).to eq Micropost.first
    expect(cat_video).to eq Micropost.last
  end

  describe 'validations' do
    subject { Micropost.new }

    describe 'user_id' do
      it { is_expected.to validate_presence_of(:user_id) }
    end

    describe 'content' do
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_length_of(:content).is_at_most(140) }
    end
  end
end
