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

ActiveRecord::Schema.define(:version => 0) do

  create_table "associations", :id => false, :force => true do |t|
    t.integer "patient_id"
    t.integer "user_id"
  end

  create_table "dispensers", :force => true do |t|
    t.string    "hash_code",       :null => false
    t.integer   "patient_id",      :null => false
    t.timestamp "date_registered", :null => false
  end

  add_index "dispensers", ["patient_id"], :name => "patient_id", :unique => true

  create_table "missed_instances", :force => true do |t|
    t.integer   "prescription_id", :null => false
    t.integer   "patient_id",      :null => false
    t.timestamp "missed_date",     :null => false
    t.text      "video_url",       :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer   "patient_id",    :null => false
    t.integer   "author_id",     :null => false
    t.text      "content",       :null => false
    t.timestamp "date_created",  :null => false
    t.integer   "reply_to_note"
  end

  create_table "patients", :force => true do |t|
    t.string    "last_name",                                 :null => false
    t.string    "first_name",                                :null => false
    t.string    "gender",                                    :null => false
    t.integer   "age",                                       :null => false
    t.string    "phone",                                     :null => false
    t.string    "address",                                   :null => false
    t.string    "avatar",                                    :null => false
    t.text      "symptoms",                                  :null => false
    t.date      "date_created",                              :null => false
    t.date      "date_terminated"
    t.string    "health_status",      :default => "healthy", :null => false
    t.datetime  "last_fall_date"
    t.float     "heart_rate"
    t.float     "blood_pressure_h"
    t.float     "blood_pressure_l"
    t.timestamp "last_status_update",                        :null => false
  end

  create_table "pills", :force => true do |t|
    t.string "name",        :null => false
    t.string "function",    :null => false
    t.string "side_effect", :null => false
    t.text   "info"
  end

  add_index "pills", ["name"], :name => "name", :unique => true

  create_table "prescriptions", :force => true do |t|
    t.integer "patient_id",            :null => false
    t.integer "doctor_id",             :null => false
    t.integer "pill_id",               :null => false
    t.text    "direction",             :null => false
    t.integer "servings_per_day",     :null => false
    t.integer "quantities_per_serving", :null => false
    t.date    "start_date",            :null => false
    t.date    "end_date",              :null => false
  end

  create_table "users", :force => true do |t|
    t.string "last_name",     :null => false
    t.string "first_name",    :null => false
    t.string "address",       :null => false
    t.string "phone",         :null => false
    t.string "usertype",      :null => false
    t.string "email",         :null => false
    t.string "password_hash", :null => false
    t.string "password_salt", :null => false
  end

  add_index "users", ["email"], :name => "email", :unique => true
  add_index "users", ["phone"], :name => "cellphone", :unique => true

end
