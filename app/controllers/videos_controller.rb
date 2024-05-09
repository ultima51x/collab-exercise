class VideosController < ApplicationController
  def index
    # TODO Need pagination
    @videos = Video.all
  end

  def refresh
    VideoImporterJob.perform_later
    flash[:notice] = "Fetching videos. New videos will populate when you come back to the page later."
    redirect_to action: :index
  end
end
