
require "rack-flash"
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :"songs/index"
  end

  get "/songs/new" do
    @genres = Genre.all
    erb :"/songs/new"
  end

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    # binding.pry
    erb :"/songs/edit"
  end

  patch "/songs/:slug" do

    artist = Artist.find_or_create_by(name: params[:artist_name])

    # binding.pry
    @song = Song.find_by_slug(params[:slug])

    @song.update(name: params[:song_name], artist: artist )

    # binding.pry
    @song.genres.each do |genre|
      if !params[:genres].keys.include?(genre.name)
        SongGenre.destroy(song: @song, genre: genre)
      end

    end

    # binding.pry

    # params[:genres].keys.each do |genre_name|
    #
    #   genre = Genre.find_by(name: genre_name)
    #
    #   SongGenre.destroy(song: @song, genre: genre)
    #
    #   # binding.pry
    # end

    flash[:message] = "Successfully updated song."
    # binding.pry
     redirect "/songs/#{@song.slug}"
  end

  get "/songs/:slug" do
    # binding.pry
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    erb :"songs/show"
  end

  post "/songs" do

    artist = Artist.find_or_create_by(name: params[:artist_name])

    @song = Song.create(name: params[:song_name], artist: artist )
    # binding.pry
    params[:genres].keys.each do |genre_name|

      genre = Genre.find_by(name: genre_name)

      SongGenre.create(song: @song, genre: genre)

      # binding.pry
    end
    # binding.pry
   flash[:message] = "Successfully created song."
   # binding.pry
    redirect "/songs/#{@song.slug}"
  end

  get "/artists" do
    @artists = Artist.all
    erb :"artists/index"
  end

  get "/artists/:slug" do
    @artist = Artist.find_by_slug(params[:slug])
    erb :"artists/show"
  end

  get "/genres" do
    @genres = Genre.all
    erb :"genres/index"
  end

  get "/genres/:slug" do
    @genre = Genre.find_by_slug(params[:slug])
    erb :"genres/show"
  end




end
