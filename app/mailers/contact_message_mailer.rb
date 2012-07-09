class ContactMessageMailer < ActionMailer::Base
  default :from => "flagship8787@gmail.com"

  def contact_message_mail( contact_message, recipient )

    contact_message_mail = mail(:to => recipient.email, :subject => contact_message.Subject)
    puts "Contact messege is: " + (contact_message_mail.nil? ? "NIL" : "NOT NIL")

    return contact_message_mail	  
  end
end
