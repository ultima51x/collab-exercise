require "rails_helper"

RSpec.describe "Playlists", type: :request do
  let!(:user) { FactoryBot.create :user }

  describe "create" do
    it "creates a playlist" do
      expect do
        post "/playlists", params: {playlist: {name: "Blah"}}
      end.to change { Playlist.where(name: "Blah").count }.by(1)

      expect(response.status).to eql 200
    end
  end

  describe "show" do
    let(:playlist) do # make a playlist w/ a bunch of videos
      pl = FactoryBot.create :playlist, user: user
      FactoryBot.create_list :playlist_entry, 10, playlist: pl do |entry, idx|
        entry.seq = idx
      end
      pl
    end

    it "loads a playlist and its videos" do
      get "/playlists/#{playlist.id}"
      # TODO
      expect(response.status).to eql 200
    end
  end

  describe "index" do
    let!(:playlists) { FactoryBot.create_list :playlist, 5, user: user }

    it "loads playlists" do
      get "/playlists"
      # TODO
      expect(response.status).to eql 200
    end
  end
end
