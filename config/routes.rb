Rails.application.routes.draw do

  # resources :tweets

  # resources :trends

  get '/map' => 'map#index'
  get '/' => 'trends#index'
  get '/:id' => 'trends#json', constraints: {:format => /json/}
end
