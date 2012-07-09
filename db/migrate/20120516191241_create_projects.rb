class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      
      t.string    :Name,                :null => true
      t.text      :Description,         :null => true
      
      t.integer   :github_auth_id,      :null => true
      
      t.integer   :GithubId,            :null => true
      t.text      :GithubAttributes,    :null => true

      t.datetime  :GithubSynced,        :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
