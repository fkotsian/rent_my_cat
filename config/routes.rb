Cats::Application.routes.draw do

  resources :cats
  resources :cat_rental_requests do

  end

  match '/cats_rental_request/:id/approve', to: 'cat_rental_requests#approve', via: [:patch], as: 'approve_request'

  match '/cats_rental_request/:id/deny', to: 'cat_rental_requests#deny', via: [:patch], as: 'deny_request'

end
