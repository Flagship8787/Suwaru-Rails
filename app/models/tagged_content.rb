class TaggedContent < ActiveRecord::Base
  belongs_to :Tag,      :foreign_key => :tag_id
  belongs_to :Content,  :polymorphic => true, :foreign_key => :content_id
end
