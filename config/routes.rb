# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount Ckeditor::Engine => "/ckeditor"

  namespace :admin do
    root "dashboards#home"
    resources :categories
    resources :users
    resources :posts, except: %i[new create edit]
  end

  namespace :author do
    resources :posts, except: :destroy
    resources :users, only: %i[show edit update]
  end

  root "static_pages#index"
  resources :categories
  resources :comments, only: %i[create destroy] do
    resources :reactions
  end
  resources :posts, only: %i[index show] do
    resources :reactions
  end
end
