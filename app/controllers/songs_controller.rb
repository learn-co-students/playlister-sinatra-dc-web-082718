require 'rack-flash'

class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :"/songs/index"
  end

  get '/songs/new' do
    erb :"/songs/new"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/show"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/edit"
  end

  post '/songs' do
    @song = Song.create(name: params[:name])
    @genre = Genre.find(params[:genre_id])
    @artist = Artist.find_or_create_by(name: params[:artist_name])

    @song.artist = @artist
    @song.genres << @genre
    @song.save
    # binding.pry

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  patch '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])
    if !params[:artist_name].empty?
      @song.artist = Artist.find_or_create_by(name: params[:artist_name])
    end
    @genre = Genre.find(params[:genre_id])
    @song.genres << @genre
    @song.save

    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end

end
