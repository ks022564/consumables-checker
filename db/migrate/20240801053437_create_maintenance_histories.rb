class CreateMaintenanceHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :maintenance_histories do |t|
      t.date :exchange_date,           null:false
      t.date :next_maintnance_day,     null:false
      t.string :worker,                null:false
      t.text :maintenance_comment,     null:false
      t.references :user,              null: false, foreign_key: true
      t.references :item,              null: false, foreign_key: true
      t.timestamps
    end
  end
end
