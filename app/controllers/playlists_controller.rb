class PlaylistsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:change_seq]

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

  def change_seq
    # Takes in a list of video_ids, then does an upsert
    @playlist = current_user.playlists.find(params[:id])

    # This is a trick to mass update sequence numbers utilizing a unique
    # index on [video_id, playlist_id]
    # There might be a smarter/more conventional way to do this, but did not look it up.
    # This won't work well if there's an obscene amount of videos in a playlist.
    PlaylistEntry.upsert_all(
      params[:video_ids].each_with_index.map { |vid, idx| {video_id: vid, playlist_id: @playlist.id, seq: idx} },
      unique_by: [:video_id, :playlist_id]
    )
    render json: true
  end

  def home
  end
end
