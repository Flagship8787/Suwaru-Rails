class Authentication < ActiveRecord::Base
  
  belongs_to  :User, :foreign_key => :user_id
  
  serialize   :AuthAttributes, Hash
  
  def self.AuthenticateUser(user = nil, omniauth = nil)
    return nil
  end
end
