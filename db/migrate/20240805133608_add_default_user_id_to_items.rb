class AddDefaultUserIdToItems < ActiveRecord::Migration[7.0]
  def change
    # すべての `user_id` を仮の有効なユーザーIDで更新
    User.find_each do |user|
      Item.where(user_id: nil).update_all(user_id: user.id)
      break # 最初のユーザーでのみ更新する
    end
    
    # デフォルト値を設定
    change_column_default :items, :user_id, 1 # 1 は仮のデフォルトユーザーID
    change_column_null :items, :user_id, false
  end
end

