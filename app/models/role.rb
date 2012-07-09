class Role < ActiveRecord::Base

  has_many  :Users, :inverse_of => :Role, :foreign_key => :role_id
  
end
