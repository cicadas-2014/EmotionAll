class AddIndexToCountries < ActiveRecord::Migration
  def change
    add_index :countries, :country_code
    add_index :countries, :overall_sentiment
  end
end
