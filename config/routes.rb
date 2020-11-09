Rails.application.routes.draw do
  devise_for :members, controllers: {
    sessions: "user/members/sessions",
    registrations: "user/members/registrations"
  }

  scope module: :user do
    resources :members, only: [:show, :edit, :update]
    resources :posts, only: [:show, :new, :create, :edit, :update, :destroy, :index]
  end
end
