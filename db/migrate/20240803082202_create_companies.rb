class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :company_name,           null:false
      t.timestamps
    end
  end
end
