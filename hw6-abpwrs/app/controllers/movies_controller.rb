# frozen_string_literal: true

class MoviesController < ApplicationController
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering = {title: :asc}
      @title_header = 'hilite'
    when 'release_date'
      ordering = {release_date: :asc}
      @date_header = 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}

    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end

    if (params[:sort] != session[:sort]) || (params[:ratings] != session[:ratings])
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to(sort: sort, ratings: @selected_ratings) && return
    end
    @movies = Movie.where(rating: @selected_ratings.keys).order(ordering)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def search_tmdb
    if params[:search_terms].to_s.empty?
      flash[:notice] = 'Invalid Search Term'
      redirect_to movies_path
    else
      @search_term = params[:search_terms]
      @movies = Movie.find_in_tmdb(params[:search_terms])
      if @movies.present?
        @movies
      else
        flash[:notice] = 'No matching movies were found on TMDb'
        redirect_to movies_path
      end
    end
  end

  def add_tmdb
    if params[:tmdb_movies].present?
      params[:tmdb_movies].keys.each do |key|
        Movie.create_from_tmdb(key)
      end
      flash[:notice] = 'Movies successfully added to Rotten Potatoes'
    else
      flash[:notice] = 'No movies selected'
    end
    redirect_to movies_path
  end
end
