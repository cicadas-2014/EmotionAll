Rails.application.routes.draw do
  get '/' => 'map#index', as: 'root'
  get '/map/show' => 'map#show'
  get '/trends/:id' => 'trends#json', constraints: {:format => /json/}, as: 'trend'
  get '/tweets/' => 'tweets#json', constraints: {:format => /json/}, as: 'tweet'
  get '/about' => 'pages#about', as: 'about'
end
