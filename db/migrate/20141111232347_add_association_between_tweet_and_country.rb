class AddAssociationBetweenTweetAndCountry < ActiveRecord::Migration
  def change
  	add_column :tweets, :country_id, :integer
  	add_index :tweets, :country_id
  end
end
