class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres


  def slug
    Slugifiable.slug(self.name)
  end

    def self.find_by_slug(str)

        self.all.each do |song|
           if song.slug == str
             return song
           end
        end
        return nil
    end
end
