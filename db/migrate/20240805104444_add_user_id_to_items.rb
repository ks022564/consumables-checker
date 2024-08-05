class AddUserIdToItems < ActiveRecord::Migration[7.0]
  def up
    # デフォルト値を設定して NULL 値を処理
    change_column_default :items, :user_id, 1 # 例えば、デフォルト値を 1 にする
    Item.where(user_id: nil).update_all(user_id: 1)
    change_column_null :items, :user_id, false
  end

  def down
    change_column_null :items, :user_id, true
    change_column_default :items, :user_id, nil
  end
end