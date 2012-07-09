class ContactMessageObserver < ActiveRecord::Observer

	observe :ContactMessage

	def after_create(contact_message)
	  
	  puts "Delivering message: " + contact_message.Subject + " there are " + (contact_message.ContactForm.ContactFormRecipients.empty? ? "0" : contact_message.ContactForm.ContactFormRecipients.size.to_s) + " recipients."
	  
	  the_mail = nil
	  
	  contact_message.ContactForm.ContactFormRecipients.each do |aRecipient|
      
      # => Create the ContactMessageRecipient Object
      aMessageRecipient = ContactMessageRecipient.new({:ContactMessage => contact_message, :ContactFormRecipient => aRecipient})
      
      if aMessageRecipient.save
        puts "We've saved!"
      else
        puts "Failed to save"
      end
      
      # => Send out the email notification
      if(the_mail = ContactMessageMailer.contact_message_mail(contact_message, aRecipient.Recipient))
  			puts "I'm going to deliver the mail"
  			the_mail.deliver
  		else
  			puts "Failed to deliver"	
  		end
	  end
	end
end
