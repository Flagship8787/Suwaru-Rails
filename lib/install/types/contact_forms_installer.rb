class ContactFormsInstaller
  def self.InstallContactForms
    puts "ContactForms Installer - Installing contact_forms."
    
    contact_forms_data_file = File.join(INSTALLER_DATA_DIR, "contact_forms.xml")
    return false if !File.exists?(contact_forms_data_file)
    
    file_obj = File.open(contact_forms_data_file, "r")
    xml_obj = Nokogiri::XML(file_obj.read)
    file_obj.close
    
    return false if xml_obj.nil?
    
    contact_form_objs = xml_obj.css("contact-forms-list > contact-form")
    return false if contact_form_objs.nil? || contact_form_objs.length <= 0
    
    count = 0
    contact_form_objs.each do |contact_form_obj|
      aContactForm = ContactForm.new
      
      aContactForm.Name = contact_form_obj["name"]
      aContactForm.Description  = contact_form_obj.at_css("description").content
      
      aContactForm.CreatedBy = User.find_by_username(contact_form_obj["created_by"])
      aContactForm.ModifiedBy = User.find_by_username(contact_form_obj["modified_by"])
      
      recipient_objs = contact_form_obj.css("recipients > recipient")
      if !recipient_objs.nil? && recipient_objs.length > 0
        recipient_objs.each do |recipient_obj|
          aFormRecipient = ContactFormRecipient.new
          
          aFormRecipient.Recipient = User.find_by_username(recipient_obj["username"])
          aFormRecipient.ContactForm = aContactForm
          
          aContactForm.ContactFormRecipients << aFormRecipient
        end
      end
      
      if aContactForm.save
        count += 1
        puts "Successfully installed contact_form: " + aContactForm.Name + "."
      end
    end
    
    puts "ContactForms Installer successfully created " + count.to_s + " of " + contact_form_objs.length.to_s + " contact_forms." 
    
    return (count == contact_form_objs.length)
  end
end