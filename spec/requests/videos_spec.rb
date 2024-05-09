require "rails_helper"

RSpec.describe "Videos", type: :request do
  describe "index" do
    it do
      get "/videos"
      expect(response.status).to eql 200
    end
  end

  describe "refresh" do
    it do
      put "/videos/refresh"
      expect(response.status).to eql 302
    end
  end
end
