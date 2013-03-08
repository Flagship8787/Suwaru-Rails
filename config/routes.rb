Suwaru::Application.routes.draw do
  
  resources :pages

  resources :site_contents

  resources :flags

  resources :tags

  resources :authentications,   :only => [:show, :create]

  root :to => "system#home"
  
=begin
 # => Resource Routing 
=end

  resources :users,             :only => [:show]
  resources :categories,        :only => [:index, :show]
  resources :contact_forms,     :only => [:show]
  resources :contact_messages,  :only => [:new, :create, :show]
  resources :comments,          :only => [:show, :new, :create]
  resources :projects,          :only => [:index, :show]
  resources :posts,             :only => [:show]
  resources :articles,          :only => [:index, :show]

=begin
 # => Devise Routes 
=end
  devise_for  :users, 
              :path => "", 
              :path_names => { 
                  :sign_in => 'login', 
                  :sign_out => 'logout', 
                  :password => 'secret', 
                  :confirmation => 'verification', 
                  :unlock => 'unblock', 
                  :registration => 'register', 
                  :sign_up => 'sign_up' 
              }

=begin
 # => Single route mapping 
=end
  match "blog" => "posts#index", :as => "blog"
  match "workshop" => "projects#index", :as => "workshop"
  match "archive" => "system#archive", :as => "archive"
  match "about_us" => "system#about_us", :as => "about_us"
  match "contact_us" => "system#contact_us", :as => "contact_us"
  
=begin
  # => Admin routes
=end
  
  match "auth/:provider/callback" => "admin/authentications#create",    :as => :auth_callback
  
  match "github_auths/:id/sync/:repo_id" => "admin/github_auths#sync",  :as => :sync_repo
  match "github_auths/:id/sync/" => "admin/github_auths#sync_all",      :as => :sync_all_repos
  
  namespace :admin do
    root :to => "system#dashboard"
    
    match "dashboard" => "system#dashboard", :as => :dashboard
    match "upload_file" => "system#upload_file", :as => :upload_file 
    
    match "receive_upload" => "site_contents#receive_upload", :as => :receive_upload

    resources :users
    resources :roles
    
    resources :tags
    resources :categories
    resources :flags
    
    resources :site_contents
    
    resources :projects
    resources :posts
    resources :pages
    resources :comments  
    
    resources :contact_forms
    resources :contact_form_recipients
    
    resources :contact_messages
  end

  match ':controller(/:action(/:id(.:format)))'
end
