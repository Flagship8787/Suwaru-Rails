class Comment < ActiveRecord::Base
  
  belongs_to :Parent,     :polymorphic => true, :foreign_key => :parent_id
  belongs_to :CreatedBy,  :foreign_key => :created_by_id, :class_name => "User"
    
  has_many   :Flags,      :as => :Flagged, :foreign_key => :flagged_id
  
  def self.Unapproved
    return Comment.where({:Approved => !nil})
  end
end
