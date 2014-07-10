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

ActiveRecord::Schema.define(version: 20140709203348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: true do |t|
    t.string   "country_code"
    t.float    "overall_sentiment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["country_code"], name: "index_countries_on_country_code", using: :btree
  add_index "countries", ["overall_sentiment"], name: "index_countries_on_overall_sentiment", using: :btree

  create_table "trends", force: true do |t|
    t.string   "name"
    t.integer  "woeid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tweet_count", default: 0
  end

  add_index "trends", ["tweet_count"], name: "index_trends_on_tweet_count", using: :btree

  create_table "tweets", force: true do |t|
    t.string   "text"
    t.string   "tweetid"
    t.string   "language"
    t.string   "country_code"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "sentiment"
    t.float    "sentiment_score"
    t.integer  "trend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["country_code"], name: "index_tweets_on_country_code", using: :btree
  add_index "tweets", ["sentiment"], name: "index_tweets_on_sentiment", using: :btree
  add_index "tweets", ["sentiment_score"], name: "index_tweets_on_sentiment_score", using: :btree
  add_index "tweets", ["text"], name: "index_tweets_on_text", using: :btree
  add_index "tweets", ["trend_id"], name: "index_tweets_on_trend_id", using: :btree

end
