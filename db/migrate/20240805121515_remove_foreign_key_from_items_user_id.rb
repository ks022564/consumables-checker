class RemoveForeignKeyFromItemsUserId < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :items, name: 'fk_rails_d4b6334db2' if foreign_key_exists?(:items, name: 'fk_rails_d4b6334db2')
  end
end
