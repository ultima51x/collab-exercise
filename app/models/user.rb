class User < ApplicationRecord
  has_many :playlists

  validates :email, uniqueness: true, presence: true
end
