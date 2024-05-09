class AddIndexToVideoTitle < ActiveRecord::Migration[7.1]
  def up
    enable_extension "btree_gin"
    execute "create index index_videos_on_title ON videos USING GIN (to_tsvector('english', title))"
  end

  def down
    execute "drop index index_videos_on_title"
    disable_extension "btree_gin"
  end
end
