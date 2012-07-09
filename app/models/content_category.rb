class ContentCategory < ActiveRecord::Base
  belongs_to :Content,  :polymorphic => true, :foreign_key => :content_id
  belongs_to :Category, :foreign_key => :category_id
end
