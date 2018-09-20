
require 'rack-flash'
class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :"songs/index"
  end

  get '/songs/new' do
    erb :"songs/new"
  end

  get '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    erb :"songs/show"
  end


  post '/songs' do
    song_name = params[:song_name]
    artist_name = params[:artist_name]
      if Artist.find_by_name(artist_name) == nil
        @artist = Artist.create(name: artist_name)
      else
        @artist = Artist.find_by_name(artist_name)
      end
    @song = Song.create(name: song_name, artist_id: @artist.id)
    params[:genres].each do |genre|
      SongGenre.create(genre_id: genre, song_id: @song.id)
    end
      flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end


  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/edit"
  end

  put '/songs/:slug' do
    song_name = params[:song_name]
    artist_name = params[:artist_name]

    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @artist.update(name: artist_name)
    @song.update(name: song_name)

    flash[:message] = "Successfully updated song."
    redirect to("/songs/#{@song.slug}")
  end


 end
