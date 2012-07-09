Suwaru::Application.routes.draw do
  
  resources :site_contents

  resources :articles

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
  resources :articles, :only => [:index, :show] do
    get 'comment', :on => :member
  end
=end

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
  match "blog" => "system#blog", :as => "blog"
  match "workshop" => "system#workshop", :as => "workshop"
  
=begin
  # => Admin routes
=end
  
  match "auth/:provider/callback" => "admin/authentications#create",    :as => :auth_callback
  
  match "github_auths/:id/sync/:repo_id" => "admin/github_auths#sync",  :as => :sync_repo
  match "github_auths/:id/sync/" => "admin/github_auths#sync_all",      :as => :sync_all_repos
  
  namespace :admin do
    root :to => "system#dashboard"
    
    resources :users
    resources :roles
    
    resources :tags
    resources :categories
    resources :flags
    
    resources :site_contents
    
    resources :projects
    resources :posts
    resources :articles
    resources :comments  
    
    resources :contact_forms
    resources :contact_form_recipients
    
    resources :contact_messages
  end

  match ':controller(/:action(/:id(.:format)))'
end
