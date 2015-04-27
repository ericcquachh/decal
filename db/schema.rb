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

ActiveRecord::Schema.define(:version => 20150427034637) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.string   "category"
    t.string   "units"
    t.string   "status"
    t.string   "department_num"
    t.string   "semester"
    t.boolean  "cs_fw"
    t.string   "description"
    t.string   "enrollment_info"
    t.string   "course_email"
    t.string   "course_website"
    t.string   "faculty_name"
    t.string   "faculty_email"
    t.boolean  "pending"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "application_url"
    t.date     "application_due"
    t.boolean  "has_syl"
    t.boolean  "has_cpf"
  end

  create_table "facilitate_ownedcourses", :force => true do |t|
    t.integer "ownedcourse_id", :default => -1
    t.integer "facilitator_id", :default => -1
  end

  create_table "facilitate_requests", :force => true do |t|
    t.integer  "request_id",  :default => -1
    t.integer  "receiver_id", :default => -1
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "favorite_courses", :force => true do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  create_table "section_times", :force => true do |t|
    t.string   "days"
    t.string   "start_time"
    t.string   "end_time"
    t.integer  "section_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.integer  "course_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "semesters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "uploads", :force => true do |t|
    t.string   "name"
    t.string   "attachment"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "syl"
    t.boolean  "cpf"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "class_level"
    t.string   "access"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
