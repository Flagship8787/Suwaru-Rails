class CreateTaggedContents < ActiveRecord::Migration
  def self.up
    create_table :tagged_contents do |t|
      
      t.integer :site_content_id, :null => true
      t.integer :tag_id,          :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :tagged_contents
  end
end
