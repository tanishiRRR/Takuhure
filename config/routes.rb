Rails.application.routes.draw do

  namespace :public do
    get 'comments/index'
    get 'comments/new'
    get 'comments/create'
    get 'comments/show'
    get 'comments/destroy'
  end
  namespace :public do
    get 'learning_records/index'
    get 'learning_records/new'
    get 'learning_records/create'
    get 'learning_records/show'
    get 'learning_records/edit'
    get 'learning_records/update'
    get 'learning_records/destroy'
  end
  namespace :public do
    get 'answers/index'
    get 'answers/new'
    get 'answers/create'
    get 'answers/show'
    get 'answers/destroy'
  end
  namespace :public do
    get 'supplemental_questions/create'
    get 'supplemental_questions/new'
    get 'supplemental_questions/destroy'
  end
  namespace :public do
    get 'questions/create'
    get 'questions/new'
    get 'questions/destroy'
    get 'questions/index'
    get 'questions/top'
    get 'questions/show'
  end
  namespace :public do
    get 'end_users/show'
    get 'end_users/edit'
    get 'end_users/update'
    get 'end_users/unsubscribe'
    get 'end_users/withdraw'
  end
  namespace :public do
    get 'homes/top'
  end
  # 会員用
  # URL /customers/sign_in ...
  devise_for :end_users, controller: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
