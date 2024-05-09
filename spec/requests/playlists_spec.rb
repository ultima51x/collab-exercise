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

  describe "add_video" do
    let!(:playlist) { FactoryBot.create :playlist, user: user }
    let!(:entry) { FactoryBot.create :playlist_entry, playlist: playlist }
    let!(:video) { FactoryBot.create :video }

    context "entry with video exists" do
      it "does not add entry" do
        expect do
          put "/playlists/#{playlist.id}/add_video", params: {video_id: entry.video_id}
        end.to change { PlaylistEntry.count }.by(0)
        expect(response.status).to eql 200
      end
    end

    context "entry with video does not exist" do
      it "adds entry" do
        expect do
          put "/playlists/#{playlist.id}/add_video", params: {video_id: video.id}
        end.to change { PlaylistEntry.count }.by(1)

        expect(response.status).to eql 200
      end
    end
  end

  describe "remove_video" do
    let!(:playlist) { FactoryBot.create :playlist, user: user }
    let!(:entry) { FactoryBot.create :playlist_entry, playlist: playlist }
    let!(:video) { FactoryBot.create :video }

    context "entry with video exists" do
      it "removes entry" do
        expect do
          put "/playlists/#{playlist.id}/remove_video.json", params: {video_id: entry.video_id}
        end.to change { PlaylistEntry.count }.by(-1)
        expect(response.status).to eql 200
      end
    end

    context "entry with video does not exist" do
      it "does not remove an entry" do
        expect do
          put "/playlists/#{playlist.id}/remove_video.json", params: {video_id: video.id}
        end.to change { PlaylistEntry.count }.by(0)
        expect(response.status).to eql 200
      end
    end
  end
end
