class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :destination
      t.date :start_date
      t.date :end_date
      t.integer :user_id

      t.timestamps
    end
  end
end