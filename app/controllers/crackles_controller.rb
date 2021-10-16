class CracklesController < ApplicationController
    post '/crackles/getMovie' do
        movie = Crackle.all.filter {|e| e.Title.gsub(/\s+/, "").downcase == params[:title].gsub(/\s+/, "").downcase && (e.ReleaseYear-params[:release_year].to_i).abs() <= 2}[0]
        movie.to_json
    end
    
    post '/crackles/addMovies' do
        Crackle.create(c_id: params[:Id], Title: params[:Title], ReleaseYear: params[:ReleaseYear]).to_json
    end
end
  