class AddDefaultUserIdToItems < ActiveRecord::Migration[7.0]
  def change
    change_column_default :items, :user_id, 6 # 1 は存在する有効な user_id に置き換えてください
  end
end

