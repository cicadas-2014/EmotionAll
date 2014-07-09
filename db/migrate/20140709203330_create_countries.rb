class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :country_code
      t.float :overall_sentiment

      t.timestamps
    end
  end
end
