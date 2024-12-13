class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.boolean :is_implement
      t.string :nature
      t.string :name
      t.integer :item_count

      t.timestamps
      
      t.belongs_to :incident
    end
  end
end
