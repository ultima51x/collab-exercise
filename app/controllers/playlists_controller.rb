class PlaylistsController < ApplicationController
  def create
    @playlist = Playlist.new(user: current_user, name: params[:playlist][:name])
    if @playlist.save
      flash[:notice] = "Created new playlist."
    else
      flash[:alert] = @playlist.errors.full_messages.join(" ")
    end
    redirect_to action: :index
  end

  def show
    @playlist = current_user.playlists.find(params[:id])
    # Sorting in controller instead of model because
    # I find that debugging scoping rules is difficult
    @videos = @playlist.playlist_entries.includes(:video).order(:seq).map(&:video)
  end

  def index
    @playlists = current_user.playlists.order(:name)
  end

  def home
  end
end
