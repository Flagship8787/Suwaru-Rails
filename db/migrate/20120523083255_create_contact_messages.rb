class CreateContactMessages < ActiveRecord::Migration
  def self.up
    create_table :contact_messages do |t|
      
      t.integer :contact_form_id
      t.integer :sender_id
      
      t.string  :Subject
      t.text    :Body

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_messages
  end
end
