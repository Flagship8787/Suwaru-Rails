class ContactForm < ActiveRecord::Base

  has_one     :SiteContent,           :foreign_key => :content_id, :inverse_of => :Content, :as => :Content

  has_many    :ContactMessages,       :foreign_key => :contact_form_id

  has_many    :ContactFormRecipients, :foreign_key => :contact_form_id, :autosave => true
  has_many    :Recipients, :through => :ContactFormRecipients
  
  attr_writer :recipient_names
  after_save  :assign_recipients
  
  def recipient_names
    @recipient_names || self.Recipients.map(&:username).join(' ')
  end

private
  def assign_recipients
    if @recipient_names
      @recipient_names.split(/\s+/).each do |aUsername|
        aUser = User.find_by_username(aUsername)
        if !self.ContactFormRecipients.exists?({:recipient_id => aUser.id})
          self.ContactFormRecipients << ContactFormRecipient.new({:recipient_id => aUser.id, :contact_form_id => self.id}) 
        end
      end
    end
  end
end
