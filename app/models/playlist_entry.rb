class PlaylistEntry < ApplicationRecord
  belongs_to :playlist
  belongs_to :video

  validates :video_id, uniqueness: {scope: :playlist_id}
end
