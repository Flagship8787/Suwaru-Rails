class Page < ActiveRecord::Base

  has_one :SiteContent, :foreign_key => :content_id, :as => :Content, :inverse_of => :Content
  accepts_nested_attributes_for :SiteContent
  
  include SuwaruContent::ContentType
  
end
