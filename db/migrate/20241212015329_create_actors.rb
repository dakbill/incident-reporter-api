class CreateActors < ActiveRecord::Migration[8.0]
  def change
    create_table :actors do |t|
      t.boolean :is_victim
      t.string :actor_type
      t.string :name
      t.string :national_id
      t.string :passport
      t.string :voter_id
      t.string :gps_address
      t.float :lat
      t.float :lng

      t.timestamps

      t.belongs_to :incident
    end
  end
end
