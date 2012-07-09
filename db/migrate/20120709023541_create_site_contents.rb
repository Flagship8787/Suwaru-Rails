class CreateSiteContents < ActiveRecord::Migration
  def self.up
    create_table :site_contents do |t|
      t.integer :created_by_id
      t.integer :modified_by_id
      t.integer :content_id
      t.string :content_type

      t.timestamps
    end
  end

  def self.down
    drop_table :site_contents
  end
end
