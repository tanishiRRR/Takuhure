Rails.application.routes.draw do

  # ゲストログイン
  # devise_scopeに渡すシンボルは単数形
  devise_scope :end_user do
    post 'end_user/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  # 会員用
  # この中に記述したex)sessionはex)publicのsessionsを参照するようになる
  devise_for :end_users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords',
  }

  scope module: :public do
    root to: 'homes#top'

    get   'end_users/my_page' => 'end_users#my_page'
    get   'end_users/information/edit' => 'end_users#edit'
    patch 'end_users/information' => 'end_users#update'
    get   'end_users/unsubscribe' => 'end_users#unsubscribe'
    patch 'end_users/withdraw' => 'end_users#withdraw'
    resources :end_users, only: [:index, :show]

    resources :questions, only: [:index, :create, :new, :show, :destroy]

    resources :supplemental_questions, only: [:create, :destroy]

    resources :answers, only: [:index, :create, :new, :edit, :destroy] do
      resources :comments, only: [:create]
      # resourceと単数形にすると、/:idがURLに含まれなくなる
      resource :favorites, only: [:create, :destroy]
    end

    resources :comments, only: [:index, :destroy]
    resources :favorites, only: [:index]

    patch 'learning_records' => 'learning_records#end_count'
    resources :learning_records

    get 'searches' => 'searches#search'

    resources :question_and_answers, only: [:index, :show]

    resources :books, only: [:create, :destroy, :update, :index]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'

    resources :categories, only: [:index, :create, :edit, :update]

    resources :end_users, only: [:show, :edit, :update]

    resources :questions, only: [:index, :show, :destroy]

    resources :supplemental_questions, only: [:destroy]

    resources :answers, only: [:index, :show, :destroy]

    resources :comments, only: [:index, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end