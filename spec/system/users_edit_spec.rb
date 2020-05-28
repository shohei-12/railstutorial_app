require 'rails_helper'

RSpec.describe 'UsersEdit', type: :system do
  before do
    @user = create(:user)
    visit edit_user_path(@user)
  end
  subject { page }
  it 'unsuccessful edit' do
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'foo@invalid'
    fill_in 'Password', with: 'foo'
    fill_in 'Confirmation', with: 'bar'
    click_button 'Save changes'
    is_expected.to have_css('.alert-danger')
  end

  it 'successful edit' do
    name = 'Foo Bar'
    email = 'foo@bar.com'
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password', with: ''
    fill_in 'Confirmation', with: ''
    click_button 'Save changes'
    is_expected.to have_current_path user_path(@user)
    is_expected.to have_css('.alert-success')
    @user.reload
    expect(name).to eq(@user.name)
    expect(email).to eq(@user.email)
  end
end
