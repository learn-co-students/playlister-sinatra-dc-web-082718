class Song < ActiveRecord::Base

  attr_reader :slug

  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    name.downcase.gsub!(' ', '-')
  end

  def self.find_by_slug(slug)
    all.find{|song| song.slug == slug}
  end

end
