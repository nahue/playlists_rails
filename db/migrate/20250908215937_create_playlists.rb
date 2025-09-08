class CreatePlaylists < ActiveRecord::Migration[8.0]
  def change
    create_table :playlists do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
  end
end
