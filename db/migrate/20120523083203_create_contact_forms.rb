class CreateContactForms < ActiveRecord::Migration
  def self.up
    create_table :contact_forms do |t|
      
      t.string  :Name,              :null => true
      t.text    :Description,       :null => true
  
      t.boolean :AllowGuest,        :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_forms
  end
end
