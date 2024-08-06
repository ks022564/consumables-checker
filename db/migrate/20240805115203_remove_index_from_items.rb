class RemoveIndexFromItems < ActiveRecord::Migration[7.0]
  def change
    # すでに外部キー制約が存在しない場合にのみ削除する
    remove_foreign_key :items, :users if foreign_key_exists?(:items, :users)
    
    # インデックスを削除
    if index_exists?(:items, :user_id, name: 'fk_rails_d4b6334db2')
      remove_index :items, name: 'fk_rails_d4b6334db2'
    end
  end
end