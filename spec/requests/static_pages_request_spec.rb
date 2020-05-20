require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  before do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET /" do
    it "show home page" do
      get root_path
      expect(response).to have_http_status(:success)
      assert_select "title", "#{@base_title}"
    end
  end

  describe "GET /home" do
    it "show home page" do
      get static_pages_home_path
      expect(response).to have_http_status(:success)
      assert_select "title", "#{@base_title}"
    end
  end

  describe "GET /help" do
    it "show help page" do
      get static_pages_help_path
      expect(response).to have_http_status(:success)
      assert_select "title", "Help | #{@base_title}"
    end
  end

  describe "GET /about" do
    it "show about page" do
      get static_pages_about_path
      expect(response).to have_http_status(:success)
      assert_select "title", "About | #{@base_title}"
    end
  end

  describe "GET /contact" do
    it "show contact page" do
      get static_pages_contact_path
      expect(response).to have_http_status(:success)
      assert_select "title", "Contact | #{@base_title}"
    end
  end

end
