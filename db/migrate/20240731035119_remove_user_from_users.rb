class RemoveUserFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :user, :string
  end
end
