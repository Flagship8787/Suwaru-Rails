class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      
      t.integer   :parent_id,       :null => true
      t.string    :parent_type,     :null => true
      
      t.integer   :poster_id,       :null => true

      t.datetime  :Approved,        :null => true
      t.integer   :approved_by_id,  :null => true

      t.text      :Body,            :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
