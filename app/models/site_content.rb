class SiteContent < ActiveRecord::Base

  belongs_to  :Content,         :foreign_key => :content_id,      :polymorphic => true
  
  belongs_to  :CreatedBy,       :foreign_key => :created_by_id,   :class_name => "User"
  belongs_to  :ModifiedBy,      :foreign_key => :created_by_id,   :class_name => "User"
  belongs_to  :PublishedBy,     :foreign_key => :published_by_id, :class_name => "User"
  
  belongs_to  :Category,        :foreign_key => :categoryid
  
  has_many    :Comments,        :foreign_key => :parent_id,       :inverse_of => :Parent
  
  has_many    :Flags,           :foreign_key => :flagged_id,      :as => :Flagged
  
  has_many    :TaggedContents,  :foreign_key => :site_content_id 
  has_many    :Tags,            :through => :TaggedContents
  
end
