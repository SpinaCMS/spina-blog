# frozen_string_literal: true

Spina::Engine.routes.draw do
  namespace :blog do
    root to: 'posts#index'

    get ':id', to: 'posts#show', as: :post

    # Redirects for old sites that used the old blog path
    get 'posts/', to: redirect('/blog'), as: :old_index
    get 'posts/:id', to: redirect('/blog/%{id}'), as: :old_post

    get 'feed.atom', to: 'posts#index', as: :rss_feed, defaults: { format: :atom }
    get 'categories/:id', to: 'categories#show', as: :category
    get 'archive/:year(/:month)', to: 'posts#archive', as: :archive_posts
  end

  namespace :admin do
    namespace :blog do
      resources :categories
      resources :posts, except: :show do
        collection do
          get :live
          get :draft
          get :future
        end
      end
    end
  end
end
