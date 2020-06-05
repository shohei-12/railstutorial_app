require 'rails_helper'

RSpec.describe 'Home', type: :system do
  describe 'Micropost Feed' do
    let(:john) { create(:user) }
    let(:david) { create(:other) }
    let(:lisa) { create(:sample) }

    subject { page }

    context 'when logged in' do
      before { log_in_as_system(john) }

      it 'view microposts of logged in users and the users they are following' do
        cat_video = create(:cat_video, user_id: john.id)
        orange = create(:orange, user_id: david.id)
        most_recent = create(:most_recent, user_id: lisa.id)
        create(:relationship_1, follower_id: john.id, followed_id: david.id)
        visit root_path
        is_expected.to have_selector 'h3', text: 'Micropost Feed'
        is_expected.to have_content cat_video.content
        is_expected.to have_content orange.content
        is_expected.not_to have_content most_recent.content
      end
    end
  end
end
