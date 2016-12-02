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

ActiveRecord::Schema.define(version: 20161202144257) do

  create_table "judge_systems", force: :cascade do |t|
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "created_user_id"
    t.string   "title"
    t.text     "content"
    t.binary   "input"
    t.binary   "output"
    t.index ["created_user_id"], name: "index_questions_on_created_user_id"
  end

  create_table "questions_users", force: :cascade do |t|
    t.integer "question_id"
    t.integer "user_id"
    t.index ["question_id"], name: "index_questions_users_on_question_id"
    t.index ["user_id"], name: "index_questions_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "account"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.index ["account"], name: "index_users_on_account", unique: true
  end

end
