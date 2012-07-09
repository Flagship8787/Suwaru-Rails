class TaggedContent < ActiveRecord::Base
  belongs_to :Tag,          :foreign_key => :tag_id
  belongs_to :SiteContent,  :foreign_key => :site_content_id
end
