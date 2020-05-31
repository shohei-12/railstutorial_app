require 'rails_helper'

RSpec.describe 'UsersDestroy', type: :system do
  subject { page }
  context 'admin user' do
    it 'successfully delete other users' do
      admin = create(:user)
      create_list(:sample, 30)
      log_in_as_system(admin)
      visit users_path
      first_page_of_users = User.paginate(page: 1)
      first_page_of_users.each do |user|
        unless user == admin
          is_expected.to have_link 'delete', href: user_path(user)
        end
      end
      accept_confirm { click_link 'delete', match: :first }
      is_expected.to have_current_path users_path
      is_expected.to have_css('.alert-success')
      expect(User.count).to eq 30
    end
  end
  context 'not  admin user' do
    it 'must not delete other users' do
      non_admin = create(:other)
      create_list(:sample, 30)
      log_in_as_system(non_admin)
      visit users_path
      is_expected.not_to have_link 'delete'
    end
  end
end
