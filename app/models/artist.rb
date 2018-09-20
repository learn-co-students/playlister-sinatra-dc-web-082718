class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    Slugifiable.slug(self.name)
  end
  def self.find_by_slug(str)

      self.all.each do |artist|
         if artist.slug == str
           return artist
         end
      end
      return nil
  end
end
