class Tag < ActiveRecord::Base

  has_many :TaggedContents, :foreign_key => :tag_id, :inverse_of => :Tag
  has_many :Content, :through => :TaggedContents

end
