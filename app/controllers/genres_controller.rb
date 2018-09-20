class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all

    erb :"/genres/index"
  end

  get '/genres/:slug' do
    @genres = Genre.all
    @genre = Genre.find {|genre| genre.slug == params["slug"]}
    @songs = @genre.songs
    @artists = @genre.artists

    erb :"/genres/show"
  end

end
