class Post < ActiveRecord::Base
  
  has_one :SiteContent, :foreign_key => :content_id, :as => :Content, :inverse_of => :Content
  
  include SuwaruContent::Commentable
  include SuwaruContent::Flaggable
  include SuwaruContent::Taggable
  include SuwaruContent::Categorizable
  
end
