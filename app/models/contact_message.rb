class ContactMessage < ActiveRecord::Base
  
  belongs_to  :Sender,                    :foreign_key => :sender_id, :class_name => "User"

  belongs_to  :ContactForm,               :foreign_key => :contact_form_id
  has_many    :ContactMessageRecipients,  :foreign_key => :contact_message_id
end
