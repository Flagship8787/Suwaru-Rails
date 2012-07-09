class CreateTaggedContents < ActiveRecord::Migration
  def self.up
    create_table :tagged_contents do |t|
      
      t.integer :content_id
      t.string  :content_type
      
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tagged_contents
  end
end
