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

ActiveRecord::Schema.define(:version => 20120822144552) do

  create_table "SystemEvents", :primary_key => "ID", :force => true do |t|
    t.integer  "CustomerID",         :limit => 8
    t.datetime "ReceivedAt"
    t.datetime "DeviceReportedTime"
    t.integer  "Facility",           :limit => 2
    t.integer  "Priority",           :limit => 2
    t.string   "FromHost",           :limit => 60
    t.text     "Message"
    t.integer  "NTSeverity"
    t.integer  "Importance"
    t.string   "EventSource",        :limit => 60
    t.string   "EventUser",          :limit => 60
    t.integer  "EventCategory"
    t.integer  "EventID"
    t.text     "EventBinaryData"
    t.integer  "MaxAvailable"
    t.integer  "CurrUsage"
    t.integer  "MinUsage"
    t.integer  "MaxUsage"
    t.integer  "InfoUnitID"
    t.string   "SysLogTag",          :limit => 60
    t.string   "EventLogType",       :limit => 60
    t.string   "GenericFileName",    :limit => 60
    t.integer  "SystemID"
    t.datetime "time"
  end

  add_index "SystemEvents", ["SysLogTag"], :name => "SysLogTagIndex"

  create_table "SystemEventsProperties", :primary_key => "ID", :force => true do |t|
    t.integer "SystemEventID"
    t.string  "ParamName"
    t.text    "ParamValue"
  end

  create_table "render_logs", :force => true do |t|
    t.integer  "completed_time"
    t.integer  "view_time"
    t.integer  "db_time"
    t.string   "action"
    t.string   "controller"
    t.datetime "time"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "system_events", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
