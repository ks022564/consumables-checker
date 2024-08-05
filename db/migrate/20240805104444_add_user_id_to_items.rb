class AddUserIdToItems < ActiveRecord::Migration[7.0]
  def up
    # 適切なユーザーを取得します。デフォルトのユーザーを設定してください。
    default_user = User.first

    # 既存のNULL値を持つレコードを更新します。
    Item.where(user_id: nil).update_all(user_id: default_user.id)

    # user_id カラムに NOT NULL 制約を追加します
    change_column_null :items, :user_id, false

    # 外部キー制約を追加します（インデックスは既に存在するため省略）
    add_foreign_key :items, :users
  end

  def down
    # 外部キー制約を削除します
    remove_foreign_key :items, :users

    # user_id カラムの NOT NULL 制約を削除します
    change_column_null :items, :user_id, true
  end
end
