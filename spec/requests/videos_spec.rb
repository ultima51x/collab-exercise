require "rails_helper"

RSpec.describe "Videos", type: :request do
  describe "index" do
    let!(:user) { FactoryBot.create :user }

    let!(:playlist) do # make a playlist w/ a bunch of videos
      pl = FactoryBot.create :playlist, user: user
      FactoryBot.create_list :playlist_entry, 10, playlist: pl do |entry, idx|
        entry.seq = idx
      end
      pl
    end

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
