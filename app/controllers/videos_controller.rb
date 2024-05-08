class VideosController < ApplicationController
  def index
    # TODO Need pagination
    @videos = Video.all
    render json: @videos.map(&:as_json) # TODO
  end

  def refresh
    VideoImporterJob.perform_later
    render json: true # TODO real payload
  end
end
