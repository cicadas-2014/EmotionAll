Rails.application.routes.draw do

  get '/map' => 'map#index'
  get '/' => 'trends#index'
end
