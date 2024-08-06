class AddForeignKeyToItems < ActiveRecord::Migration[7.0]
  def up
    # 外部キー制約が存在しない場合のみ追加
    unless foreign_key_exists?(:items, :users)
      add_foreign_key :items, :users
    end
  end

  def down
    # 外部キー制約を削除
    if foreign_key_exists?(:items, :users)
      remove_foreign_key :items, :users
    end
  end

  private

  # 外部キー制約の存在をチェックするメソッド
  def foreign_key_exists?(from_table, to_table)
    foreign_keys(from_table).any? { |fk| fk.to_table == to_table.to_s }
  end
end
