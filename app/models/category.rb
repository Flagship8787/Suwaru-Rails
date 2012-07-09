class Category < ActiveRecord::Base
  
  has_many :SiteContents, :foreign_key => :category_id
  
end
