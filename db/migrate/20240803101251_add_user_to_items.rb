class AddUserToItems < ActiveRecord::Migration[7.0]
  def up
    # まずuser_idカラムをNULL許容で追加
    add_reference :items, :user, foreign_key: true

    # NULL値を持つuser_idカラムにデフォルト値を設定
    execute "UPDATE items SET user_id = 1 WHERE user_id IS NULL"

    # NOT NULL制約を追加
    change_column_null :items, :user_id, false
  end

  def down
    # user_idカラムを削除
    remove_reference :items, :user, foreign_key: true
  end
end