Rails.application.routes.draw do
  resources :connections
  resources :clients
  resources :professionals do
    resources :bookings
    resources :reviews
    resources :services
    resources :work_portfolios
    resources :calendly_tokens
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
