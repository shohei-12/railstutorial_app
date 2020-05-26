require 'rails_helper'

RSpec.describe 'UsersSignup', type: :system do
  describe 'GET /signup' do
    before { visit signup_path }
    subject { page }
    it 'invalid signup information' do
      fill_in 'Name', with: ''
      fill_in 'Email', with: 'user@invalid'
      fill_in 'Password', with: 'foo'
      fill_in 'Confirmation', with: 'bar'
      expect { click_button 'Create my account' }.to change(User, :count).by(0)
      is_expected.to have_css '#error_explanation'
    end
    it 'valid signup information' do
      fill_in 'Name', with: 'Example User'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'foobar'
      fill_in 'Confirmation', with: 'foobar'
      expect { click_button 'Create my account' }.to change(User, :count).by(1)
      is_expected.to have_current_path user_path(User.last)
      is_expected.to have_css '.alert-success'
    end
  end
end
