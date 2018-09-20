class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    self.name.gsub(/\s/,"-").downcase
  end

  def self.find_by_slug(slug)
    genre_name = slug.split("-").collect do |word|
      word.capitalize
    end.join(" ")
    Genre.find_by_name(genre_name)
  end

end
