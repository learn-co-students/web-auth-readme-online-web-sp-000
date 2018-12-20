Rails.application.routes.draw do
  root 'searches#search'
  get '/search', to: 'searches#search'
  post '/search', to: 'searches#foursquare'
  get '/auth', to: 'sessons#create' #redirects to session controller and create action
  get '/friends', to: 'searches#friends'#got to search controller and add a friends method

end
