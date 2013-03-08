class Post < ActiveRecord::Base

	using_access_control
  
	has_one :SiteContent, :as => :Content, :foreign_key => :content_id, :inverse_of => :Content, :dependent => :destroy
	accepts_nested_attributes_for :SiteContent
  
	include SuwaruContent::ContentType
  
	include SuwaruContent::Commentable
	include SuwaruContent::Flaggable
	include SuwaruContent::Taggable
	include SuwaruContent::Categorizable
  
end
