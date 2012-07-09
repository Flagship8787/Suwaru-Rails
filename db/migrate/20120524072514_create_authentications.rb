class CreateAuthentications < ActiveRecord::Migration
  def self.up
    create_table :authentications do |t|
      
      t.string    :type,            :null => true
      
      t.integer   :user_id,         :null => true
      t.string    :Token,           :null => true
      
      t.text      :AuthAttributes,  :null => true

      t.string    :AccountName,     :null => true
      t.string    :AccountNickname, :null => true
      
      t.string    :ProfileURL,      :null => true
      t.string    :AvatarURL,       :null => true
      
      t.timestamps
    end
  end

  def self.down
    drop_table :authentications
  end
end
