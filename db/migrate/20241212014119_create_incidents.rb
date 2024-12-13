class CreateIncidents < ActiveRecord::Migration[8.0]
  def change
    create_table :incidents do |t|
      t.string :status
      t.text :description
      t.string :incident_type
      t.string :reported_by
      t.datetime :time_of_incident

      t.timestamps

      t.belongs_to :user, null: true
    end
  end
end
