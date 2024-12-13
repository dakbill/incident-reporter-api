class CreateOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :options do |t|
      t.string :option_type
      t.string :name

      t.timestamps
    end
  end
end
