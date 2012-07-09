class Comment < ActiveRecord::Base
  
  belongs_to :Parent,         :foreign_key => :parent_id,       :polymorphic => true
  belongs_to :Poster,         :foreign_key => :poster_id,       :class_name => "User"
  belongs_to :ApprovedBy,     :foreign_key => :approved_by_id,  :class_name => "User"
    
  has_many    :ContentFlags,  :as => :Flagged, :foreign_key => :flagged_id 
  has_many    :Flags,         :through => :ContentFlags
  
  def self.Unapproved
    return Comment.where({:Approved => !nil})
  end
end
