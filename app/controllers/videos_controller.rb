class VideosController < ApplicationController
  def index
    @videos = Video.all
    @playlists = current_user.playlists.order(:name)

    # We need to know which videos belong to which playlists, so storing this
    # as a set of [video_id, playlist_id] pairs
    # If a video is in a playlist, check if the [video.id, playlist.id] is in the set
    @playlist_entries_set = Set.new(PlaylistEntry.joins(playlist: :user).where(user: {id: 1}).pluck(:video_id, :playlist_id))
  end

  def refresh
    VideoImporterJob.perform_later
    flash[:notice] = "Fetching videos. New videos will populate when you come back to the page later."
    redirect_to action: :index
  end
end
