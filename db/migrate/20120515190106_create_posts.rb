class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      
      t.string  :Title,             :null => true
      t.text    :Body,              :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
