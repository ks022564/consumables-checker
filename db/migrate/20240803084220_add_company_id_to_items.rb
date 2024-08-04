class AddCompanyIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :company_id, :integer
  end
end
