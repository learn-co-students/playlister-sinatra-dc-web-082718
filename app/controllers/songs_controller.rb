
class SongsController < ApplicationController

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
    genre = params[:genres][0]


    @artist = Artist.create(name: artist_name)
    @song = Song.create(name: song_name, artist_id: @artist.id)
    @song_genre = SongGenre.create(genre_id: genre, song_id: @song.id)

    # binding.binding.pryex
    flash[:message] = "Successfully created song."

    redirect to("/songs/#{@song.slug}")
  end

end
