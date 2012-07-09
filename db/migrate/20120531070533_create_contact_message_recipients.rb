class CreateContactMessageRecipients < ActiveRecord::Migration
  def self.up
    create_table :contact_message_recipients do |t|
      
      t.integer   :contact_message_id,          :null => true
      t.integer   :contact_form_recipient_id,   :null => true
      
      t.datetime  :MessageRead,                 :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_message_recipients
  end
end
