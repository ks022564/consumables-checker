class AddForeignKeyToItems < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :items, :users
  end
end
