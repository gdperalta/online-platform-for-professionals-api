Rails.application.routes.draw do
  get '/subscribers', to: 'connections#subscribers'
  get '/subscribed_to', to: 'connections#subscribed_to'
  get '/clientele', to: 'connections#clientele'
  get '/my_professionals', to: 'connections#my_professionals'
  resources :connections, only: %i[create destroy]
  resources :clients, only: %i[index show destroy]
  resources :professionals do
    resources :bookings
    resources :reviews
    resources :services
    resources :work_portfolios
    resources :calendly_tokens, except: :index
  end
  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: '/login',
               sign_out: '/logout',
               registration: '/signup'
             },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations',
               confirmations: 'users/confirmations'
             }
end
