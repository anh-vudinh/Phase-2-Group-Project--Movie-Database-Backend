class WatchlistsController < ApplicationController
    post '/watchlists/retrieveWL' do
        UserSessionTokenList.all.find_by(session_token: params[:token]).user.watchlist_cards.to_json     #locate user based off token recieved
    end
end