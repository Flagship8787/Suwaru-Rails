class CreateContentCategories < ActiveRecord::Migration
  def self.up
    create_table :content_categories do |t|
      t.integer :content_id
      t.string :content_type
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :content_categories
  end
end
