class Video < ApplicationRecord
  validates :external_ref, uniqueness: true, presence: true
end

