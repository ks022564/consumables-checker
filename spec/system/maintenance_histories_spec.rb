require 'rails_helper'

RSpec.describe "MaintenanceHistories", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @maintenance_history = FactoryBot.build(:maintenance_history, user: @user, item: @item)
  end

  context '点検記録を登録できる時' do
    it 'ログインしたユーザーは点検記録を登録できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)

      # 詳細ページに遷移する
      visit item_path(@item)
      
      # フォームに情報を入力する
      fill_in 'exchange_date', with: @maintenance_history.exchange_date
      fill_in 'next_maintenance_day', with: @maintenance_history.next_maintenance_day
      fill_in 'コメント', with: @maintenance_history
      fill_in '実施者', with: @maintenance_history

      # 送信するとMaintenanceHistoryモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
        sleep 1
      }.to change { MaintenanceHistory.count }.by(1)

      # 詳細画面にリダイレクトすることを確認する
      expect(current_path).to eq item_path(@item)
      
      # 詳細画面には先ほど投稿した内容が表示することを確認する
      expect(page).to have_content(@previous_inspection_date)
      expect(page).to have_content(@next_maintenance_day)
      expect(page).to have_content(@maintenance_comment)
    end  
  end
  context '点検記録を登録できない時' do
    it 'ログインしていないユーザーは点検記録を登録できない' do
      # トップページに遷移する
      visit root_path
      # アイテム詳細ページへ遷移する
      visit item_path(@item)
      # 編集ページへのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_item_path(@item)
    end
  end
end
