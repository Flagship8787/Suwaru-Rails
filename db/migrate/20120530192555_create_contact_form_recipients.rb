class CreateContactFormRecipients < ActiveRecord::Migration
  def self.up
    create_table :contact_form_recipients do |t|
      
      t.integer :recipient_id
      t.integer :contact_form_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_form_recipients
  end
end
