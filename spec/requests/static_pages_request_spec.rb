require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /' do
    it 'show home page' do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include full_title
    end
  end

  describe 'GET /help' do
    it 'show help page' do
      get help_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include full_title('Help')
    end
  end

  describe 'GET /about' do
    it 'show about page' do
      get about_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include full_title('About')
    end
  end

  describe 'GET /contact' do
    it 'show contact page' do
      get contact_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include full_title('Contact')
    end
  end
end
