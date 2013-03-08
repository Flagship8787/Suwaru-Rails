authorization do 
  role :web_master do
    has_permission_on [:admin_posts, :posts],                   :to => [:administrate]
    has_permission_on [:admin_projects, :projects],             :to => [:administrate]
    has_permission_on [:admin_site_contents, :site_contents],   :to => [:administrate]
    has_permission_on [:admin_categories, :categories],         :to => [:administrate]
    has_permission_on [:admin_users, :users],                   :to => [:administrate]

    has_permission_on [:tinymce],                               :to => [:use_advanced]
  end
  
  role :administrator do
    
  end
  
  role :visitor do

  end

  role :anonymous do
    has_permission_on :site_contents, :to => :index
    has_permission_on :site_contents, :to => :view do
      if_attribute :Published => is { true }
    end
    has_permission_on :site_contents, :to => :comment do
      if_attribute :AnonymousComments => true
    end

    has_permission_on [:posts, :projects], :to => :index
    has_permission_on [:posts, :projects], :to => :view do
      if_permitted_to :view, :SiteContent
    end    
  end  
end

privileges do
  privilege :view,          :includes => [:read, :show]
  privilege :browse,        :includes => [:view, :index]
  
  privilege :maintain,      :includes => [:view, :edit, :update]
  privilege :own,           :includes => [:maintain, :destroy, :delete]
  
  privilege :make,          :includes => [:index, :new, :create]
  
  privilege :administrate,  :includes => [:make, :own]
end