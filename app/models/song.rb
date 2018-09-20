class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    self.name.gsub(/\s/,"-").downcase
  end

  def self.find_by_slug(slug)
    # song_name = slug.split("-").collect do |word|
    #   case word
    #   when "with","to","a","the"
    #       word
    #     else
    #       word.capitalize
    #   end
    # end.join(" ")
    # Song.find_by_name(song_name)

    Song.all.find { |song|
      song.slug == slug
    }
  end

end
