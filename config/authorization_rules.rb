authorization do 
  role :web_master do
    has_permission_on [:admin_posts, :posts],           :to => [:administrate]
    has_permission_on [:admin_categories, :categories], :to => [:administrate]
    has_permission_on [:admin_projects, :projects],     :to => [:administrate]
    
    has_permission_on [:tinymce],                       :to => [:use_advanced]
  end
  
  role :administrator do
    
  end
  
  role :visitor do
  
  end
  
  role :guest do
    has_permission_on [:posts],                         :to => [:view]  
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