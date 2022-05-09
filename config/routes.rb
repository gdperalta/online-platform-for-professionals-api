Rails.application.routes.draw do
  resources :connections
  resources :professionals do
    resources :reviews
    resources :services
    resources :work_portfolios
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
               registrations: 'users/registrations'
             }
end
