# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_23_202639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "group_events", force: :cascade do |t|
    t.string "name", limit: 200
    t.text "description"
    t.string "location", limit: 200
    t.boolean "published", default: false, null: false
    t.integer "duration"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_group_events_on_deleted_at"
    t.index ["name"], name: "index_group_events_on_name", unique: true
  end

end
