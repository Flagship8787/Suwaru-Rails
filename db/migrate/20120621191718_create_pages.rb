class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :Title
      t.text :Body
      t.integer :created_by_id
      t.integer :modified_by_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
