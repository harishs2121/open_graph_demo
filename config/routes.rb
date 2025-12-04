Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      post "create_ogp_data",     to: "open_graphs#set_ogp_data"
      get "retrieve_ogp_data",     to: "open_graphs#get_ogp_data"
      get 'open_graphs', to: 'open_graphs#index'
    end
  end
end
