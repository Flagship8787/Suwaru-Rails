class ContactFormRecipient < ActiveRecord::Base
  
  belongs_to  :Recipient,                 :foreign_key => :recipient_id,    :class_name => "User"
  belongs_to  :ContactForm,               :foreign_key => :contact_form_id
  
  has_many    :ContactMessageRecipients,  :foreign_key => :contact_form_recipient_id
  
end
