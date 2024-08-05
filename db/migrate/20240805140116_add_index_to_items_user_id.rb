class AddIndexToItemsUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :items, :user_id
  end
end
