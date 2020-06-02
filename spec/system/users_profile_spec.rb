require 'rails_helper'

RSpec.describe 'UsersProfile', type: :system do
  subject { page }
  it 'show the microposts correctly' do
    user = create(:user)
    create_list(:orange, 31, user_id: user.id)
    visit user_path(user)
    is_expected.to have_content 'Microposts（31）'
    user.microposts.paginate(page: 1).each do |micropost|
        is_expected.to have_content micropost.content
    end
    is_expected.to have_css('ul.pagination', count: 1)
  end
end
