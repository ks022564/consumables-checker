class RemoveIndexFromItemsUserId < ActiveRecord::Migration[7.0]
  def change
    if index_exists?(:items, :user_id, name: 'index_items_on_user_id')
      remove_index :items, name: 'index_items_on_user_id'
    end
  end
end
