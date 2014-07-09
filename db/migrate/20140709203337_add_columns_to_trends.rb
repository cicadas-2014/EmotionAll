class AddColumnsToTrends < ActiveRecord::Migration
  def change
    add_column :trends, :tweet_count, :integer
    add_index :trends, :tweet_count
  end
end
