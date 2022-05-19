Rails.application.routes.draw do
  get '/subscribers', to: 'connections#subscribers'
  get '/subscribed_to', to: 'connections#subscribed_to'
  get '/clientele', to: 'connections#clientele'
  get '/my_professionals', to: 'connections#my_professionals'
  resources :connections, only: %i[create destroy]
  resources :clients, only: %i[index show destroy]
  resources :bookings, except: :create
  resources :professionals do
    post '/bookings', to: 'bookings#create', as: 'bookings'
    resources :reviews
    resources :services
    resources :work_portfolios
    resources :calendly_tokens, except: :index
    collection do
      match 'search' => 'professionals#search', via: %i[get post], as: :search
    end
  end
  patch '/users/:id/approve', to: 'users#approve', as: 'approve_user'
  get '/fields', to: 'fields#index'
  get '/cities', to: 'locations#cities'
  get '/regions', to: 'locations#regions'
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
