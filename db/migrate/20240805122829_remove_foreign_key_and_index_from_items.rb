class RemoveForeignKeyAndIndexFromItems < ActiveRecord::Migration[7.0]
  def change
    # 外部キー制約を削除
    if foreign_key_exists?(:items, :users)
      remove_foreign_key :items, :users
    end

    # インデックスを削除
    if index_exists?(:items, :user_id)
      remove_index :items, name: 'fk_rails_d4b6334db2'
    end
  end
end
