require "mock_youtube_api"

class VideoImporterJob < ApplicationJob
  queue_as :default

  def perform
    api = MockYoutubeApi.new

    # Limiting to 100 pages arbitrarily
    (1...100).each do |page|
      results = api.videos(page)
      break if results["videos"].blank?

      records_to_upsert = results["videos"].map do |attrs|
        {
          external_ref: attrs["video_id"],
          title: attrs["title"],
          thumbnail: attrs["thumbnail_url"],
          description: attrs["description"],
          views: attrs["views"]
        }
      end

      Video.upsert_all(records_to_upsert, unique_by: [:external_ref])
    end
  end
end
