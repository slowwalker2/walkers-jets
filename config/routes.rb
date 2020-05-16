Jets.application.routes.draw do
  get  "links", to: "links#index"
  get  "links/:id", to: "links#show"
  post  "links", to: "links#create"
  delete  "links", to: "links#delete"
end
