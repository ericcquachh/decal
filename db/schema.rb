# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20150403004759) do

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.string   "category"
    t.string   "units"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
<<<<<<< HEAD
    t.string   "uid"
=======
    t.string   "days"
    t.integer  "uid"
>>>>>>> d7b08f572ef14a4c8f835d5b0274aaeb013ec9b7
  end

  create_table "sections", :force => true do |t|
    t.string   "section_title"
    t.string   "facilitator"
    t.integer  "size"
    t.integer  "ccn_ld"
    t.integer  "ccn_ud"
    t.boolean  "ccn_publish"
    t.boolean  "status"
    t.string   "first_day"
    t.string   "location"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "course_id"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "days"
  end

  create_table "uploads", :force => true do |t|
    t.string   "name"
    t.string   "attachment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "course_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "class_level"
    t.boolean  "facilitator",            :default => false
    t.string   "access"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
