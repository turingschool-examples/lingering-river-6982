Rails.application.routes.draw do

  resources :scientists, only: [:show] do
    resources :experiments, only: [:index, :show] do
      member do
        delete 'remove', to: 'scientist_experiments#destroy'
      end
    end
  end

  resources :experiments, only: [:index]
end