Rails.application.routes.draw do
  get '/offers/search', to: 'offers#display_search_form', as: 'search_offers'
  post '/offers/search', to: 'offers#submit_search_form'
end
