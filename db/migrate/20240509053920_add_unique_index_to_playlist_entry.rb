class AddUniqueIndexToPlaylistEntry < ActiveRecord::Migration[7.1]
  def change
    add_index :playlist_entries, [:playlist_id, :video_id], unique: true
  end
end
