class ContactMessageRecipient < ActiveRecord::Base
  
  belongs_to :ContactMessage,       :foreign_key => :contact_message_id
  belongs_to :ContactFormRecipient, :foreign_key => :contact_form_recipient_id
  
end
