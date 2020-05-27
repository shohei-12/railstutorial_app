require 'rails_helper'

RSpec.describe 'UsersLogin', type: :system do
  describe 'login' do
    subject { page }
    before { visit login_path }
    let(:user) { create(:user) }

    context 'valid information' do
      before do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end
      it 'log in' do
        is_expected.to have_current_path user_path(user)
        is_expected.not_to have_link 'Log in', href: login_path
        click_link 'Account'
        is_expected.to have_link 'Profile', href: user_path(user)
        is_expected.to have_link 'Log out', href: logout_path
      end
      it 'log out after log in' do
        click_link 'Account'
        click_link 'Log out'
        is_expected.to have_current_path root_path
        is_expected.to have_link 'Log in', href: login_path
        is_expected.not_to have_link 'Account'
        is_expected.not_to have_link 'Profile', href: user_path(user)
        is_expected.not_to have_link 'Log out', href: logout_path
      end
    end

    context 'invalid information' do
      it 'log in' do
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        click_button 'Log in'
        is_expected.to have_css('.alert-danger')
        visit root_path
        is_expected.not_to have_css('.alert-danger')
      end
      it 'login with valid email/invalid password' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'invalid'
        click_button 'Log in'
        is_expected.to have_css('.alert-danger')
        visit root_path
        is_expected.not_to have_css('.alert-danger')
      end
    end

    describe 'remember me' do
      it 'login with remembering' do
        log_in_with_remember_as(user, remember_me: '1')
        expect(cookies[:user_id]).not_to eq nil
        expect(cookies[:remember_token]).not_to eq nil
      end

      it 'login without remembering' do
        log_in_with_remember_as(user)
        expect(cookies[:user_id]).to eq nil
        expect(cookies[:remember_token]).to eq nil
      end
    end
  end
end
