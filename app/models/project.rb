class Project < ActiveRecord::Base

  has_one :SiteContent, :foreign_key => :content_id, :as => :Content, :inverse_of => :Content
  
end
