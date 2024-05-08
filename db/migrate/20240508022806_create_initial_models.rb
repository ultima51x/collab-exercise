class CreateInitialModels < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :thumbnail
      t.string :description
      t.bigint :views # maybe the view count can get crazy???
      t.string :external_ref

      t.timestamps
    end

    add_index :videos, :external_ref, unique: true

    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end

    add_index :users, :email, unique: true

    create_table :playlists do |t|
      t.references :user, foreign_key: {on_delete: :cascade}

      t.string :name

      t.timestamps
    end

    add_index :playlists, [:user_id, :name], unique: true

    create_table :playlist_entries do |t|
      t.references :playlist, foreign_key: {on_delete: :cascade}
      t.references :video, foreign_key: {on_delete: :cascade}
      t.integer :seq

      t.timestamps
    end
  end
end
