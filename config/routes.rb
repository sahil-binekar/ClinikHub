Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :accounts do
    collection do
      post :signup
      post :login
    end
  end

  resources :patients do
    collection do
      get :patient_graph
    end
  end
end
