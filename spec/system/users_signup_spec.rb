require 'rails_helper'

RSpec.describe 'UsersSignup', type: :system do
  describe 'GET /signup' do
    it 'invalid signup information' do
      visit signup_path
      fill_in 'Name', with: ''
      fill_in 'Email', with: 'user@invalid'
      fill_in 'Password', with: 'foo'
      fill_in 'Confirmation', with: 'bar'
      expect { click_button 'Create my account' }.to change(User, :count).by(0)
      expect(page).to have_css '#error_explanation'
    end

    it 'valid signup information' do
      visit signup_path
      fill_in 'Name', with: 'Example User'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Confirmation', with: 'password'
      expect { click_button 'Create my account' }.to change(User, :count).by(1)
      expect(page).to have_css '.alert-success'
    end
  end
end
