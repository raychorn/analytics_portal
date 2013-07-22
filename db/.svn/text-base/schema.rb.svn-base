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

ActiveRecord::Schema.define(:version => 20110824183949) do

  create_table "configurations", :force => true do |t|
    t.string   "name"
    t.string   "locale"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_dashboard_id"
  end

  create_table "dashboard_reports", :force => true do |t|
    t.integer  "dashboard_id"
    t.integer  "report_id"
    t.datetime "added_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "size"
    t.integer  "position"
  end

  create_table "dashboards", :force => true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "shared",        :default => false
    t.integer  "position"
    t.integer  "filter_set_id"
  end

  create_table "data_segment_job_runners", :force => true do |t|
    t.integer "data_segment_id"
    t.integer "job_runner_id"
  end

  create_table "data_segments", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "data_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "properties"
    t.string   "schedule"
    t.boolean  "enable_schedule", :default => false
  end

  create_table "data_sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "database_name"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "filter_param_associations", :force => true do |t|
    t.integer  "filter_param_id"
    t.integer  "optionable_id"
    t.string   "optionable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filter_params", :force => true do |t|
    t.string   "type"
    t.string   "column"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_period"
    t.integer  "min_period",              :default => 604800
    t.text     "values"
    t.string   "date_column"
    t.string   "default_name"
    t.integer  "report_query_id"
    t.string   "interval"
    t.boolean  "enable_dynamic_values",   :default => false
    t.integer  "dynamic_values_query_id"
    t.boolean  "enable_for_filter_sets",  :default => false
  end

  create_table "filter_prefs", :force => true do |t|
    t.integer  "optionable_id"
    t.string   "optionable_type"
    t.text     "values"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "period"
    t.string   "selected"
    t.boolean  "filter_enabled"
    t.boolean  "enable_email"
    t.integer  "alert_direction"
    t.string   "name"
    t.string   "target"
    t.integer  "user_id"
    t.integer  "filter_param_association_id"
    t.float    "lat",                         :default => 0.0
    t.float    "lng",                         :default => 0.0
    t.integer  "zoom",                        :default => 0
  end

  create_table "filter_sets", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "ability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_roles", :id => false, :force => true do |t|
    t.integer "permission_id"
    t.integer "role_id"
  end

  create_table "queries", :force => true do |t|
    t.integer  "data_segment_id"
    t.text     "query_string"
    t.boolean  "store_in_db"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "query_result_id"
    t.text     "sample_data"
    t.string   "name"
  end

  create_table "report_links", :force => true do |t|
    t.string   "name"
    t.integer  "report_id"
    t.integer  "linked_report_id"
    t.string   "filter_columns"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_queries", :force => true do |t|
    t.integer  "report_id"
    t.integer  "query_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "chart_type"
    t.text     "chart_params"
    t.string   "x_column"
    t.string   "y_column"
    t.string   "radius_column"
    t.string   "name_column"
    t.string   "query_select_group"
    t.text     "sql_string"
    t.integer  "y_axis",             :default => 0
  end

  create_table "reports", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "highcharts_params"
    t.string   "type"
    t.string   "table_columns"
    t.integer  "sample_option",     :default => 0
    t.integer  "filter_set_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_dashboards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "dashboard_id"
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => ""
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
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.boolean  "global_admin",                          :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
