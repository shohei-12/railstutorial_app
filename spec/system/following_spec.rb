require 'rails_helper'

RSpec.describe 'Following', type: :system do
  before do
    @user = create(:user)
    @other = create(:other)
    log_in_as_system(@user)
  end

  subject { page }

  it 'display correct a follow page' do
    create(:relationship_1, follower_id: @user.id, followed_id: @other.id)
    visit following_user_path(@user)
    is_expected.to have_link '1 following', href: following_user_path(@user)
    is_expected.to have_link '0 followers', href: followers_user_path(@user)
    @user.following.each do |user|
      is_expected.to have_link user.name, href: user_path(user)
    end
  end

  it 'display correct a follower page' do
    create(:relationship_2, follower_id: @other.id, followed_id: @user.id)
    visit followers_user_path(@user)
    is_expected.to have_link '0 following', href: following_user_path(@user)
    is_expected.to have_link '1 followers', href: followers_user_path(@user)
    @user.followers.each do |user|
      is_expected.to have_link user.name, href: user_path(user)
    end
  end

  it 'follow/unfollow other users' do
    visit user_path(@other)
    click_button 'Follow'
    is_expected.to have_content '1 followers'
    is_expected.to have_button 'Unfollow'
    click_button 'Unfollow'
    is_expected.to have_content '0 followers'
    is_expected.to have_button 'Follow'
  end
end
