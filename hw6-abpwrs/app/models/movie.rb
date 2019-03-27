# frozen_string_literal: true

require 'themoviedb'
Tmdb::Api.key('f4702b08c0ac6ea5b51425788bb26562')

class Movie < ActiveRecord::Base
  def self.all_ratings
    %w[G PG PG-13 NC-17 R]
  end

  class Movie::InvalidKeyError < StandardError
  end

  def self.find_in_tmdb(string)
    begin
      matching_movies = Tmdb::Movie.find(string)
      movies = nil
      if matching_movies
        movies = []
        matching_movies.each do |tmdb_movie|
          rating = get_rating tmdb_movie.id
          # could be used to filteer out incomplete data
          if rating.present? && tmdb_movie.release_date.to_s.present?
            movies << { tmdb_id: tmdb_movie.id, title: tmdb_movie.title,
                        rating: rating, release_date: tmdb_movie.release_date }
          end
        end
      end
    rescue Tmdb::InvalidApiKeyError
      raise Movie::InvalidKeyError, 'Invalid API key'
    end
    movies
  end

  def self.create_from_tmdb(id)
    details = Tmdb::Movie.detail(id)
    movie = { title: details['title'], rating: get_rating(id), description: details['overview'], release_date: details['release_date'] }
    Movie.create! movie
  end

  def self.get_rating(id)
    rating = nil
    releases = Tmdb::Movie.releases(id)
    if releases.present? && releases['countries']
      releases['countries'].each do |country|
        rating = country['certification'].to_s if country['iso_3166_1'].to_s.casecmp('US').zero?
      end
    else
      rating = 'NR'
    end
    rating
  end
end
