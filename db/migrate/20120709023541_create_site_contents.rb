class CreateSiteContents < ActiveRecord::Migration
  def self.up
    create_table :site_contents do |t|
      
      t.integer   :content_id,          :null => true
      t.string    :content_type,        :null => true
      
      t.integer   :created_by_id,       :null => true
      t.integer   :modified_by_id,      :null => true
      t.integer   :published_by_id,     :null => true
      
      t.integer   :category_id,         :null => true

      t.string    :Banner_file_name,    :null => true
      t.integer   :Banner_file_size,    :null => true
      t.datetime  :Banner_updated_at,   :null => true

      t.string    :Thumb_file_name,     :null => true
      t.integer   :Thumb_file_size,     :null => true
      t.datetime  :Thumb_updated_at,     :null => true
      
      t.boolean   :Published,           :default => false
      t.datetime  :PublishedAt,         :null => true

      t.boolean   :isFeatured,          :default => false

      t.boolean   :AllowComments,       :default => true
      t.boolean   :AnonymousComments,   :default => true
      t.boolean   :ApproveComments,     :default => true
      t.integer   :CommentDepth,        :default => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :site_contents
  end
end
