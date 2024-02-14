Rails.application.routes.draw do
 root "dashboards#index"

 post '/search', to: 'dashboards#search'

 get '/clipboard' => 'clipboards#index'

 get '/clipboard_stimulus' => 'clipboard_stimulus#index'

end
