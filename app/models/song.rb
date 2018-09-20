class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    self.name.gsub(/\s/,"-").downcase
  end

  def self.find_by_slug(slug)
    song_name = slug.split("-").collect do |word|
      word.capitalize
    end.join(" ")
    Song.find_by_name(song_name)
  end

end
