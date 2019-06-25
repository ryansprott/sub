class CreateEquipment < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment do |t|
      t.string :ada
      t.string :borough
      t.string :equipment_number
      t.string :equipment_type
      t.string :serving
      t.string :station
      t.string :train_number
      t.timestamps
    end
  end
end
