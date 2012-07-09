# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120709023541) do

  create_table "articles", :force => true do |t|
    t.string   "Title"
    t.text     "Body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.string   "Token"
    t.text     "AuthAttributes"
    t.string   "AccountName"
    t.string   "AccountNickname"
    t.string   "ProfileURL"
    t.string   "AvatarURL"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "Name"
    t.string   "Description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.integer  "poster_id"
    t.datetime "Approved"
    t.integer  "approved_by_id"
    t.text     "Body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_form_recipients", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "contact_form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_forms", :force => true do |t|
    t.string   "Name"
    t.text     "Description"
    t.boolean  "AllowGuest",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_message_recipients", :force => true do |t|
    t.integer  "contact_message_id"
    t.integer  "contact_form_recipient_id"
    t.datetime "MessageRead"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_messages", :force => true do |t|
    t.integer  "contact_form_id"
    t.integer  "sender_id"
    t.string   "Subject"
    t.text     "Body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", :force => true do |t|
    t.integer  "flagged_id"
    t.string   "flagged_type"
    t.integer  "flagged_by_id"
    t.string   "FlaggedByIP"
    t.text     "Comment"
    t.datetime "ReviewedAt"
    t.integer  "removed_by_id"
    t.datetime "RemovedAt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "Title"
    t.text     "Body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "Name"
    t.text     "Description"
    t.integer  "github_auth_id"
    t.integer  "GithubId"
    t.text     "GithubAttributes"
    t.datetime "GithubSynced"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "Name"
    t.text     "Description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_contents", :force => true do |t|
    t.integer  "content_id"
    t.string   "content_type"
    t.integer  "category_id"
    t.integer  "created_by_id"
    t.integer  "modified_by_id"
    t.integer  "published_by_id"
    t.datetime "Published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tagged_contents", :force => true do |t|
    t.integer  "site_content_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "Name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "role_id"
    t.string   "username"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
