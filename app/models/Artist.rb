class Artist < ActiveRecord::Base

  attr_reader :slug

  has_many :songs
  has_many :genres, through: :songs

  def slug
    name.downcase.gsub!(' ', '-')
  end

  def self.find_by_slug(slug)
    all.find{|artist| artist.slug == slug}
  end

end
