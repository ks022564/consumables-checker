class AddCompanyIdToMaintenanceHistories < ActiveRecord::Migration[7.0]
  def change
    add_column :maintenance_histories, :company_id, :integer
  end
end
