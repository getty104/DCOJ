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

ActiveRecord::Schema.define(version: 20161226065630) do

  create_table "blocks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id", "target_user_id"], name: "index_blocks_on_user_id_and_target_user_id", unique: true
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id", "target_user_id"], name: "index_follows_on_user_id_and_target_user_id", unique: true
  end

  create_table "judge_systems", force: :cascade do |t|
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.integer  "category"
    t.index ["question_id"], name: "index_posts_on_question_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "title"
    t.text     "content"
    t.binary   "input"
    t.binary   "output"
    t.integer  "created_user_id"
    t.integer  "question_level"
    t.text     "input_text"
    t.text     "output_text"
    t.text     "sample_input"
    t.text     "sample_output"
    t.index ["created_user_id"], name: "index_questions_on_created_user_id"
  end

  create_table "questions_users", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "question_id", null: false
    t.index ["question_id"], name: "index_questions_users_on_question_id"
    t.index ["user_id"], name: "index_questions_users_on_user_id"
  end

  create_table "records", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "question_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "result"
    t.index ["question_id"], name: "index_records_on_question_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "name"
    t.string   "account"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "solved_question_number"
    t.integer  "created_question_number"
    t.index ["account"], name: "index_users_on_account", unique: true
  end

end
