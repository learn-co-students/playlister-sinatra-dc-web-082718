class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs


  def slug
    self.name.gsub(/\s/,"-").downcase
  end

  def self.find_by_slug(slug)
    artist_name = slug.split("-").collect do |word|
      word.capitalize
    end.join(" ")
    Artist.find_by_name(artist_name)
  end

end
