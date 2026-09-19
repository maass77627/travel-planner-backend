class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :location
      t.integer :day
      t.integer :trip_id

      t.timestamps
    end
  end
end
