Rails.application.routes.draw do
    devise_for :users,

             path: '',

             path_names: {

               sign_in: 'login',

               sign_out: 'logout',

               registration: 'signup'

             },

             controllers: {

               sessions: 'users/sessions',

               registrations: 'users/registrations'

             }
    post "validator", to: "validator#view"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
