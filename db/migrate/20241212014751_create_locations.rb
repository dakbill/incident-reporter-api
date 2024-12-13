class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :description
      t.float :lat
      t.float :lng
      t.string :district
      t.string :region

      t.timestamps

      t.belongs_to :incident
    end
  end
end
