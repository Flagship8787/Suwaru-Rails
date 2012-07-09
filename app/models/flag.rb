class Flag < ActiveRecord::Base
  
  belongs_to :Flagged,    :polymorphic => true, :foreign_key => :flagged_id
  
  belongs_to :FlaggedBy,  :foreign_key => :flagged_by_id, :class_name => "User"
  belongs_to :RemovedBy,  :foreign_key => :removed_by_id, :class_name => "User"
  
  validates_presence_of :Comment
  
  def self.NeverRemoved
    return Flag.where(:RemovedAt => !nil)
  end
end
