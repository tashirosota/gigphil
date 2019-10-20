Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'searcher#show'
  get 'searcher', to: 'searcher#show'
  get 'result', to: 'results#index' 
end
