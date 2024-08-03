class RenameNextMaintnanceDayInMaintenanceHistories < ActiveRecord::Migration[7.0]
  def change
    rename_column :maintenance_histories, :next_maintnance_day, :next_maintenance_day
  end
end
