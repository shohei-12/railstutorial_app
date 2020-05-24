require 'rails_helper'

RSpec.describe 'SiteLayout', type: :system do
  describe 'GET /' do
    subject { page }
    it 'exist links to the root_path, help_path, about_path, and contact_path' do
      visit root_path
      is_expected.to have_link nil, href: root_path, count: 2
      is_expected.to have_link 'Help', href: help_path
      is_expected.to have_link 'About', href: about_path
      is_expected.to have_link 'Contact', href: contact_path
    end
  end
end
