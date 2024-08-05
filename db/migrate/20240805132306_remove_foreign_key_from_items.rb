class RemoveForeignKeyFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :items, :users if foreign_key_exists?(:items, :users)
  end
end
