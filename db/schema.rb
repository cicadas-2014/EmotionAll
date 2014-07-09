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

ActiveRecord::Schema.define(version: 20140709183103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "adminpack"
  enable_extension "autoinc"
  enable_extension "btree_gin"
  enable_extension "btree_gist"
  enable_extension "chkpass"
  enable_extension "citext"
  enable_extension "cube"
  enable_extension "dblink"
  enable_extension "dict_int"
  enable_extension "dict_xsyn"
  enable_extension "earthdistance"
  enable_extension "file_fdw"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"
  enable_extension "insert_username"
  enable_extension "intagg"
  enable_extension "intarray"
  enable_extension "isn"
  enable_extension "lo"
  enable_extension "ltree"
  enable_extension "moddatetime"
  enable_extension "pageinspect"
  enable_extension "pg_buffercache"
  enable_extension "pg_freespacemap"
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "pgrowlocks"
  enable_extension "pgstattuple"
  enable_extension "refint"
  enable_extension "seg"
  enable_extension "sslinfo"
  enable_extension "tablefunc"
  enable_extension "tcn"
  enable_extension "test_parser"
  enable_extension "timetravel"
  enable_extension "tsearch2"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"
  enable_extension "xml2"

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
    t.integer  "tweet_count"
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
