require 'rack-flash'

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :"songs/index"
  end

  get '/songs/new' do
    @genres = Genre.all

    erb :"songs/new"
  end

  post '/songs' do
#  {"song_name"=>"That One with the Guitar", "Artist Name"=>"Person with a Face", "New Age Garbage"=>"on"}
  @song = Song.find_or_create_by(name: params["Name"])
  @song.artist = Artist.find_or_create_by(name: params["Artist Name"])

  params[:genres].each do |id|
    SongGenre.create(song_id: @song.id, genre_id: id)
  end


  @song.save
  flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.all.find {|song| song.slug == params["slug"]}
    @artist = @song.artist

    erb :"songs/show"
  end



end
