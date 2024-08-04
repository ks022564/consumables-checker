class AddCompanyToUsers < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:users, :company_id)
      add_reference :users, :company, null: false, foreign_key: true
    end  
  end
end
