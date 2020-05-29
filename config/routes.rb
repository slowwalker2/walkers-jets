Jets.application.routes.draw do
  get "user_links", to: "user_links#index"
  get "user_links/:id", to: "user_links#show"
  post "user_links/:id/rating", to: "user_links#rating"
  post "user_links/:id/note", to: "user_links#note"
  post "user_links", to: "user_links#create"
  delete "user_links/:id", to: "user_links#delete"
end
