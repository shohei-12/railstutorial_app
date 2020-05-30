require 'rails_helper'

RSpec.describe 'UsersIndex', type: :system do
  subject { page }
  it 'must be redirected to the login form if you are not logged in' do
    visit users_path
    is_expected.to have_current_path login_path
  end

  it 'view the user list page if you are logged in' do
    user = create(:user)
    create_list(:sample, 30)
    log_in_as_system(user)
    visit users_path
    is_expected.to have_current_path users_path
    is_expected.to have_css('ul.pagination', count: 2)
    User.paginate(page: 1).each do |user|
      is_expected.to have_link user.name, href: user_path(user)
    end
  end
end
