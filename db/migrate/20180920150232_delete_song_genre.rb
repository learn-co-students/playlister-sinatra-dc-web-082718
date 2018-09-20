class DeleteSongGenre < ActiveRecord::Migration
  def change
    drop_table :song_genre
  end
end
