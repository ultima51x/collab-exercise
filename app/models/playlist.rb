class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_entries
  has_many :videos, through: :playlist_entries
end
