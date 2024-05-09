require "rails_helper"

RSpec.describe "Playlists", type: :request do
  let!(:user) { FactoryBot.create :user }

  let(:playlist) do # make a playlist w/ a bunch of videos
    pl = FactoryBot.create :playlist, user: user
    FactoryBot.create_list :playlist_entry, 10, playlist: pl do |entry, idx|
      entry.seq = idx
    end
    pl
  end

  describe "create" do
    it "makes a playlist" do
      expect do
        post "/playlists", params: {playlist: {name: "Blah"}}
      end.to change { Playlist.where(name: "Blah").count }.by(1)

      expect(response.status).to eql 302
    end
  end

  describe "show" do
    it do
      get "/playlists/#{playlist.id}"
      expect(response.status).to eql 200
    end
  end

  describe "index" do
    let!(:playlists) { FactoryBot.create_list :playlist, 5, user: user }

    it do
      get "/playlists"
      expect(response.status).to eql 200
    end
  end

  describe "change_seq" do
    it "updates the sequence numbers" do
      playlist
      shuffled_ids = playlist.videos.map(&:id).shuffle
      put "/playlists/#{playlist.id}/change_seq", params: {video_ids: shuffled_ids}

      # check that the sequence for the 3rd element is idx 2 is 2
      expect(PlaylistEntry.find_by(playlist: playlist, video_id: shuffled_ids[2]).seq).to eql 2

      expect(response.status).to eql 200
    end
  end
end
