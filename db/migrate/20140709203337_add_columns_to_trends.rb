class AddColumnsToTrends < ActiveRecord::Migration
  def change
    add_column :trends, :tweet_count, :integer, default: 0
    add_index :trends, :tweet_count
  end
end
