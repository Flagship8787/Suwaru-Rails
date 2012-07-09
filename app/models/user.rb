class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  belongs_to  :Role,                      :foreign_key => :role_id
  
  has_many    :CreatedContents,           :foreign_key => :created_by_id,   :inverse_of => :CreatedBy,    :class_name => "SiteContent"
  has_many    :ModifiedContents,          :foreign_key => :modified_by_id,  :inverse_of => :ModifiedBy,   :class_name => "SiteContent"
  
  has_many    :ContactFormRecipients,     :foreign_key => :recipient_id,    :inverse_of => :Recipient
  has_many    :SentMessages,              :foreign_key => :sender_id,       :inverse_of => :Sender,       :class_name => "ContactMessage"
  
  has_many    :Authentications,           :foreign_key => :user_id
  has_one     :TwitterAuth,               :foreign_key => :user_id
  has_one     :FacebookAuth,              :foreign_key => :user_id
  has_one     :GithubAuth,                :foreign_key => :user_id
  
  has_many    :Comments,                  :foreign_key => :poster_id,       :inverse_of => :Poster
  
  has_many    :Flags,                     :foreign_key => :flagged_by_id,   :inverse_of => :FlaggedBy
  has_many    :FlagsRemoved,              :foreign_key => :removed_by_id,   :inverse_of => :RemovedBy,    :class_name => "Flag"
  
  def role_symbols
    [ self.Role.Name.downcase.split(" ").join("_").to_sym ] 
  end
  
  def UnreadMessages    
    return ContactMessageRecipient.joins([:ContactFormRecipient]).where(["contact_form_recipients.recipient_id=? AND contact_message_recipients.MessageRead IS NULL", self.id])
  end
end