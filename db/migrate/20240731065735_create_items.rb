class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :consumable_name,        null: false
      t.string :consumable_model_number,null: false
      t.string :consumable_maker,       null: false
      t.string :equipment_name,         null: false
      t.string :equipment_model_number, null: false
      t.string :serial_number,          null: false
      t.integer :inspection_interval,    null: false
      t.date   :start_date,             null: false
      t.timestamps
    end
  end
end
