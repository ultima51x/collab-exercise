class PlaylistEntriesController < ApplicationController
  def create
    video = Video.find_by(id: params[:video_id])
    playlist = current_user.playlists.find_by(id: params[:playlist_id])

    if video && playlist
      @entry = PlaylistEntry.create(video: video, playlist: playlist)
      render json: @entry
    else
      raise NotImplementedError
    end
  end

  def destroy
    @entry = PlaylistEntry.find(params[:id])
    @entry.destroy!
    render json: nil
  end
end
