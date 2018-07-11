class CreateStops < ActiveRecord::Migration[5.1]
  def change
    create_table :stops do |t|
      t.string :gtfs_id
      t.string :line_name
      t.string :stop_name
      t.string :routes
      t.string :lat
      t.string :lon
      t.timestamps
    end
  end
end
