class AddTimeAndNotesToActivities < ActiveRecord::Migration[8.1]
  def change
    add_column :activities, :time, :string
    add_column :activities, :notes, :text
  end
end
