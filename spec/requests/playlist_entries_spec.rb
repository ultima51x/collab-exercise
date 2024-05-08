require "rails_helper"

RSpec.describe "PlaylistEntries", type: :request do
  let!(:user) { FactoryBot.create :user }

  describe "create" do
    let!(:playlist) { FactoryBot.create :playlist, user: user }
    let!(:video) { FactoryBot.create :video }

    it "creates an entry" do
      post "/playlist_entries", params: {video_id: video.id, playlist_id: playlist.id}
      expect(response.status).to eql 200
    end
  end

  describe "destroy" do
    let!(:entry) { FactoryBot.create :playlist_entry }

    it "deletes an entry" do
      expect do
        delete "/playlist_entries/#{entry.id}"
      end.to change { PlaylistEntry.count }.by(-1)
      expect(response.status).to eql 200
    end
  end

  describe "move" do
    let(:entry) { FactoryBot.create :playlist_entry }

    it do
      put "/playlist_entries/#{entry.id}/move"
      skip "not implemented"
    end
  end
end
