require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  before do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET /home" do
    it "show home page" do
      get static_pages_home_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include "Home | #{@base_title}"
    end
  end

  describe "GET /help" do
    it "show help page" do
      get static_pages_help_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include "Help | #{@base_title}"
    end
  end

  describe "GET /about" do
    it "show about page" do
      get static_pages_about_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include "About | #{@base_title}"
    end
  end

end
