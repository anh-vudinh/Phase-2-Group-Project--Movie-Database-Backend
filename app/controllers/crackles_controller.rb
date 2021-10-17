class CracklesController < ApplicationController
    post '/crackles/getMovie' do
        movie = Crackle.all.filter {|e| e.short_title == params[:title].gsub(/\s+/, "").downcase && (e.release_year-params[:release_year].to_i).abs() <= 2}[0]
        movie.to_json
    end
    
    post '/crackles/addMovies' do
        params[:crackles].each do |movie|
            Crackle.create(c_id: movie[:Id], title: movie[:Title], short_title: cleanShortTitle(movie), release_year: movie[:ReleaseYear])
        end
        puts "done adding movies".to_json
    end

    def cleanShortTitle(movie)
        short_title_initial = movie[:Title].gsub(/\s+/, "").downcase
        year_index = short_title_initial.index "("
        if(year_index == nil)
            short_title_initial
        else
            short_title_final = short_title_initial[0,year_index]
        end
    end
end
  