require 'rails_helper'

RSpec.describe 'MicropostsInterface', type: :system do
  subject { page }

  describe 'create and delete microposts' do
    before do
      @user = create(:user)
      log_in_as_system(@user)
      visit root_path
    end

    context 'create a micropost' do
      it 'send a invalid micropost' do
        fill_in 'micropost_content', with: ''
        expect { click_button 'Post' }.to change(Micropost, :count).by(0)
        is_expected.to have_css('div.alert-danger')
      end

      it 'send a valid micropost' do
        fill_in 'micropost_content', with: 'foobar'
        attach_file 'micropost_image',
                    "#{Rails.root}/spec/factories/images/kitten.jpg"
        expect { click_button 'Post' }.to change(Micropost, :count).by(1)
        is_expected.to have_css('div.alert-success')
        is_expected.to have_content 'foobar'
        is_expected.to have_selector 'img'
      end
    end

    context 'delete a micropost' do
      it 'successfully deleted' do
        fill_in 'micropost_content', with: 'foobar'
        click_button 'Post'
        accept_confirm { click_link 'delete' }
        visit current_path
        expect(Micropost.count).to eq 0
      end
    end
  end

  context 'Accessing other users profile pages' do
    it 'no deleted link' do
      other = create(:other)
      create(:orange, user_id: other.id)
      visit user_path(other)
      is_expected.to have_content 'I just ate an orange!'
      is_expected.not_to have_link 'delete'
    end
  end
end
