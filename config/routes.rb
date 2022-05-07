Rails.application.routes.draw do
  resources :professionals do
    resources :reviews
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
