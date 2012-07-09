class CreateSiteContents < ActiveRecord::Migration
  def self.up
    create_table :site_contents do |t|
      
      t.integer   :content_id,        :null => true
      t.string    :content_type,      :null => true
      
      t.integer   :category_id,       :null => true
      
      t.integer   :created_by_id,     :null => true
      t.integer   :modified_by_id,    :null => true
      t.integer   :published_by_id,   :null => true
      
      t.datetime  :Published,         :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :site_contents
  end
end
