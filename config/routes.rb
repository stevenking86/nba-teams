Rails.application.routes.draw do
  root to: 'teams#index'

  get '/chart-set', to: 'teams#chart_set'
end
