class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|

      t.integer   :flagged_id,          :null => true
      t.string    :flagged_type,        :null => true
      
      t.integer   :flagged_by_id,       :null => true
      t.string    :FlaggedByIP,         :null => true

      t.text      :Comment,             :null => true
      
      t.datetime  :ReviewedAt,          :null => true

      t.integer   :removed_by_id,       :null => true
      t.datetime  :RemovedAt,           :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :flags
  end
end
