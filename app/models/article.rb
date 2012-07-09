class Article < ActiveRecord::Base

  has_one :SiteContent, :foreign_key => :content_id, :as => :Content, :inverse_of => :Content
  accepts_nested_attributes_for :SiteContent

  include SuwaruContent::ContentType
  
  include SuwaruContent::Commentable
  include SuwaruContent::Flaggable
  include SuwaruContent::Taggable
  include SuwaruContent::Categorizable

end
