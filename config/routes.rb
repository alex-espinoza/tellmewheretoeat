Tellmewheretoeat::Application.routes.draw do

  get 'home' => 'pages#home', :as => 'home', :format => false
  post 'location' => 'pages#location', :as => 'post_location'
  get 'result' => 'pages#result', :as => 'get_result'

  root :to => 'pages#home'
end
