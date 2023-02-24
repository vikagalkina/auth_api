Rails.application.routes.draw do
  resources :users, only: %i[create] do
    collection do
      post :authenticate
    end
  end
end
