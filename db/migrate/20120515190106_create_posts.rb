class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      
      t.string  :Title
      t.text    :Body
      
      t.integer :created_by_id
      t.integer :modified_by_id

      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
