class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      
      t.integer   :parent_id,       :null => true
      t.string    :parent_type,     :null => true
      
      t.integer   :created_by_id,   :null => true

      t.datetime  :Approved,        :null => true
      t.boolean   :Flagged,         :default => false

      t.text      :Body,            :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
