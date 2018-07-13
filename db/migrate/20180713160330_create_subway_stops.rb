class CreateSubwayStops < ActiveRecord::Migration[5.1]
  def change
    create_table :subway_stops do |t|
      t.string :gtfs_id
      t.string :line_name
      t.string :stop_name
      t.string :routes
      t.timestamps
    end
  end
end
