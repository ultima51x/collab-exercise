class PlaylistsController < ApplicationController
  def create
    @playlist = Playlist.create(user: current_user, name: params[:playlist][:name])
    render json: @playlist.as_json # TODO
  end

  def show
    # TODO list videos too...
    @playlist = current_user.playlists.find(params[:id])
    # Sorting here instead of using scopes or the model because debugging scoping rules is difficult
    @videos = @playlist.playlist_entries.includes(:video).order(:seq).map(&:video)
    render json: [@playlist.as_json, @videos.map(&:as_json)]
  end

  def index
    @playlists = current_user.playlists
    render json: @playlists
  end
end
