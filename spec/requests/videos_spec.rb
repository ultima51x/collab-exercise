require "rails_helper"

RSpec.describe "Videos", type: :request do
  describe "index" do
    it "shows videos" do
      get "/videos"
      # TODO
      expect(response.status).to eql 200
    end
  end

  describe "refresh" do
    it "triggers refresh of video ingestion" do
      put "/videos/refresh"

      expect(response.status).to eql 200
    end
  end
end
