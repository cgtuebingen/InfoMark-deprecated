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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160803104824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "info"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "course_groups", ["course_id"], name: "index_course_groups_on_course_id", using: :btree
  add_index "course_groups", ["user_id"], name: "index_course_groups_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
    t.date     "begin"
    t.date     "termination"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "show_exam_approval", default: false
    t.integer  "min_points",         default: 0
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "role",       default: 0
  end

  add_index "enrollments", ["user_id", "course_id"], name: "index_enrollments_on_user_id_and_course_id", using: :btree

  create_table "exam_grades", force: :cascade do |t|
    t.float    "points"
    t.float    "mark"
    t.text     "info"
    t.integer  "user_id"
    t.integer  "exam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "exam_grades", ["exam_id"], name: "index_exam_grades_on_exam_id", using: :btree
  add_index "exam_grades", ["user_id"], name: "index_exam_grades_on_user_id", using: :btree

  create_table "exams", force: :cascade do |t|
    t.string   "title"
    t.integer  "course_id"
    t.datetime "date"
    t.text     "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "bonus"
  end

  add_index "exams", ["course_id"], name: "index_exams_on_course_id", using: :btree

  create_table "exercise_sheets", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "order"
    t.text     "file"
    t.datetime "publish"
    t.datetime "duedate"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "exercise_sheets", ["course_id"], name: "index_exercise_sheets_on_course_id", using: :btree
  add_index "exercise_sheets", ["user_id"], name: "index_exercise_sheets_on_user_id", using: :btree

  create_table "exercise_tasks", force: :cascade do |t|
    t.integer  "order"
    t.integer  "exercise_sheet_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "max_points"
    t.string   "public_test"
    t.string   "private_test"
  end

  add_index "exercise_tasks", ["exercise_sheet_id"], name: "index_exercise_tasks_on_exercise_sheet_id", using: :btree

  create_table "globalnotifications", force: :cascade do |t|
    t.text     "body"
    t.datetime "start"
    t.datetime "ends"
    t.integer  "visibility"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gradings", force: :cascade do |t|
    t.integer  "submission_id"
    t.text     "feedback"
    t.integer  "points"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "tutor_id"
    t.integer  "user_id"
    t.integer  "exercise_sheet_id"
    t.integer  "course_group_id"
    t.boolean  "ready",             default: false
  end

  add_index "gradings", ["course_group_id"], name: "index_gradings_on_course_group_id", using: :btree
  add_index "gradings", ["exercise_sheet_id"], name: "index_gradings_on_exercise_sheet_id", using: :btree
  add_index "gradings", ["tutor_id"], name: "index_gradings_on_tutor_id", using: :btree
  add_index "gradings", ["user_id"], name: "index_gradings_on_user_id", using: :btree

  create_table "group_enrollment_preferences", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_group_id"
    t.integer  "rating"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "group_enrollment_preferences", ["course_group_id"], name: "index_group_enrollment_preferences_on_course_group_id", using: :btree
  add_index "group_enrollment_preferences", ["user_id"], name: "index_group_enrollment_preferences_on_user_id", using: :btree

  create_table "group_enrollments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "group_enrollments", ["course_group_id"], name: "index_group_enrollments_on_course_group_id", using: :btree
  add_index "group_enrollments", ["user_id"], name: "index_group_enrollments_on_user_id", using: :btree

  create_table "linecomments", force: :cascade do |t|
    t.integer  "submission_id"
    t.string   "file_name"
    t.integer  "line"
    t.string   "comment"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "linecomments", ["submission_id"], name: "index_linecomments_on_submission_id", using: :btree
  add_index "linecomments", ["user_id"], name: "index_linecomments_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "recipients"
    t.text     "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "overall_averages", force: :cascade do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points_caches", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "exercise_sheet_id"
    t.integer  "points"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "points_caches", ["exercise_sheet_id"], name: "index_points_caches_on_exercise_sheet_id", using: :btree
  add_index "points_caches", ["user_id"], name: "index_points_caches_on_user_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "slides", force: :cascade do |t|
    t.string   "file"
    t.integer  "course_id"
    t.datetime "publish"
    t.boolean  "public"
    t.date     "lecture"
    t.string   "info"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "slides", ["course_id"], name: "index_slides_on_course_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "exercise_task_id"
    t.string   "file"
    t.text     "log"
    t.text     "private_log"
    t.text     "raw_log"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "status",           default: 0
  end

  add_index "submissions", ["exercise_task_id"], name: "index_submissions_on_exercise_task_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "supplementaries", force: :cascade do |t|
    t.string   "file"
    t.integer  "course_id"
    t.string   "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "visibility"
  end

  add_index "supplementaries", ["course_id"], name: "index_supplementaries_on_course_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name",             default: "",    null: false
    t.string   "last_name",              default: "",    null: false
    t.boolean  "root",                   default: false, null: false
    t.text     "avatar"
    t.text     "student_number"
    t.text     "subject"
    t.text     "semester"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "course_groups", "courses"
  add_foreign_key "course_groups", "users"
  add_foreign_key "exam_grades", "exams"
  add_foreign_key "exam_grades", "users"
  add_foreign_key "exams", "courses"
  add_foreign_key "exercise_sheets", "courses"
  add_foreign_key "exercise_sheets", "users"
  add_foreign_key "exercise_tasks", "exercise_sheets"
  add_foreign_key "gradings", "course_groups"
  add_foreign_key "gradings", "exercise_sheets"
  add_foreign_key "gradings", "users"
  add_foreign_key "gradings", "users", column: "tutor_id"
  add_foreign_key "group_enrollment_preferences", "course_groups"
  add_foreign_key "group_enrollment_preferences", "users"
  add_foreign_key "group_enrollments", "course_groups"
  add_foreign_key "group_enrollments", "users"
  add_foreign_key "linecomments", "submissions"
  add_foreign_key "linecomments", "users"
  add_foreign_key "points_caches", "exercise_sheets"
  add_foreign_key "points_caches", "users"
  add_foreign_key "slides", "courses"
  add_foreign_key "submissions", "exercise_tasks"
  add_foreign_key "submissions", "users"
  add_foreign_key "supplementaries", "courses"
end
