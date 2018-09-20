class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.all
    erb :"artists/index"
  end

  get '/artists/:slug' do
    @artists = Artist.all
    @artist = @artists.find {|artist| artist.slug == params["slug"]}
    @genres = @artist.genres
    @songs =  @artist.songs

    erb :"artists/show"
  end

end
