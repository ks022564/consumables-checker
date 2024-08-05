class RemoveIndexFromItemsUserId < ActiveRecord::Migration[7.0]
  def change
    remove_index :items, name: 'fk_rails_d4b6334db2' if index_exists?(:items, :user_id, name: 'fk_rails_d4b6334db2')
  end
end
