# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090316145352) do

  create_table "invitations", :force => true do |t|
    t.string   "email"
    t.string   "user_agent"
    t.string   "referer"
    t.string   "host"
    t.integer  "inviter_user_id"
    t.integer  "signup_user_id"
    t.string   "random_key"
    t.integer  "sent_email_ok"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occurrences", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.string   "title"
    t.text     "data"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "uri"
    t.integer  "mind_tree_id"
  end

  create_table "subjects", :force => true do |t|
    t.string "type"
    t.string "foreign_id"
    t.string "name"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "description"
    t.float    "price"
    t.integer  "max_topics"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "public_visible"
    t.integer  "subject"
    t.integer  "subject_id"
    t.integer  "latitude"
    t.integer  "longitude"
    t.text     "data"
    t.string   "uri"
    t.string   "title_lower"
  end

  create_table "topics_associations", :force => true do |t|
    t.integer "association_id"
    t.integer "topic_id"
  end

  create_table "topics_occurrences", :force => true do |t|
    t.integer "occurrence_id"
    t.integer "topic_id"
    t.integer "latitude"
    t.integer "longitude"
  end

  create_table "topics_topics", :force => true do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "latitude"
    t.integer "longitude"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "pasword"
    t.string   "email"
    t.integer  "enabled"
    t.integer  "supervisor"
    t.integer  "invitations"
    t.integer  "subscription_id"
    t.string   "paypal_id"
    t.date     "last_delicious_import"
    t.date     "last_google_apps_import"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_topics", :force => true do |t|
    t.integer "topic_id"
    t.integer "user_id"
  end

end
