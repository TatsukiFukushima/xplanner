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

ActiveRecord::Schema.define(version: 20181022075646) do

  create_table "approaches", force: :cascade do |t|
    t.string "content"
    t.integer "effectiveness", default: 0, null: false
    t.integer "row_order"
    t.integer "short_term_goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0
    t.integer "comments_count", default: 0
    t.integer "user_id"
    t.integer "status", default: 0, null: false
    t.index ["short_term_goal_id"], name: "index_approaches_on_short_term_goal_id"
    t.index ["user_id"], name: "index_approaches_on_user_id"
  end

  create_table "block_relationships", force: :cascade do |t|
    t.integer "blocker_id"
    t.integer "blocked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_id"], name: "index_block_relationships_on_blocked_id"
    t.index ["blocker_id", "blocked_id"], name: "index_block_relationships_on_blocker_id_and_blocked_id", unique: true
    t.index ["blocker_id"], name: "index_block_relationships_on_blocker_id"
  end

  create_table "comment_replies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comment_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comment_replies_on_comment_id"
    t.index ["user_id"], name: "index_comment_replies_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type"
    t.integer "commentable_id"
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "deadlines", force: :cascade do |t|
    t.string "due_date_type"
    t.integer "due_date_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["due_date_type", "due_date_id"], name: "index_deadlines_on_due_date_type_and_due_date_id"
  end

  create_table "likes", force: :cascade do |t|
    t.string "likable_type"
    t.integer "likable_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likable_type", "likable_id", "user_id"], name: "index_likes_on_likable_type_and_likable_id_and_user_id", unique: true
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "long_term_goals", force: :cascade do |t|
    t.string "category"
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row_order"
    t.integer "status", default: 0, null: false
    t.integer "likes_count", default: 0
    t.integer "comments_count", default: 0
    t.index ["user_id"], name: "index_long_term_goals_on_user_id"
  end

  create_table "memos", force: :cascade do |t|
    t.string "memoable_type"
    t.integer "memoable_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memoable_type", "memoable_id"], name: "index_memos_on_memoable_type_and_memoable_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "from_id"
    t.integer "to_id"
    t.string "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id", "created_at"], name: "index_messages_on_room_id_and_created_at"
  end

  create_table "mid_term_goals", force: :cascade do |t|
    t.string "content"
    t.integer "row_order"
    t.integer "long_term_goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.integer "likes_count", default: 0
    t.integer "comments_count", default: 0
    t.integer "user_id"
    t.index ["long_term_goal_id"], name: "index_mid_term_goals_on_long_term_goal_id"
    t.index ["user_id"], name: "index_mid_term_goals_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "short_term_goals", force: :cascade do |t|
    t.string "content"
    t.integer "status", default: 0, null: false
    t.integer "row_order"
    t.integer "mid_term_goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0
    t.integer "comments_count", default: 0
    t.integer "user_id"
    t.index ["mid_term_goal_id"], name: "index_short_term_goals_on_mid_term_goal_id"
    t.index ["user_id"], name: "index_short_term_goals_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "xroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
    t.index ["xroom_id"], name: "index_subscriptions_on_xroom_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "xmessages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "xroom_id"
    t.index ["user_id"], name: "index_xmessages_on_user_id"
    t.index ["xroom_id"], name: "index_xmessages_on_xroom_id"
  end

  create_table "xrooms", force: :cascade do |t|
    t.integer "user_id"
    t.string "category"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["user_id"], name: "index_xrooms_on_user_id"
  end

end
