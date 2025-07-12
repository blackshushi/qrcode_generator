Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "qr_codes#index"

  post '/generate', to: 'qr_codes#generate', as: :generate_qr_code
end
