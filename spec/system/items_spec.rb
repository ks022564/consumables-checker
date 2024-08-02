require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end

  context 'アイテム登録できる時' do
    it 'ログインしたユーザーはアイテム登録できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
      
      # アイテム登録ページへのボタンがあることを確認する
      expect(page).to have_content('アイテム登録')
      
      # 投稿ページに移動する
      visit new_item_path
      
      # フォームに情報を入力する
      fill_in '設備名', with: @item.equipment_name
      fill_in '設備型番', with: @item.equipment_model_number
      fill_in 'シリアルナンバー', with: @item.serial_number
      fill_in '消耗品名', with: @item.consumable_name
      fill_in '消耗品型番', with: @item.consumable_model_number
      fill_in 'メーカー', with: @item.consumable_maker
      fill_in '点検周期 (日)', with: @item.inspection_interval
      fill_in '使用開始日', with: @item.start_date
      
      # 送信するとItemモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { Item.count }.by(1)
      
      # トップページには先ほど投稿した内容のアイテムが存在することを確認する
      expect(page).to have_content(@item.equipment_name)
      expect(page).to have_content(@item.equipment_model_number)
      expect(page).to have_content(@item.serial_number)
      expect(page).to have_content(@item.consumable_name)
      expect(page).to have_content(@item.consumable_model_number)
      expect(page).to have_content(@item.consumable_maker)
    end  
  end

  context 'アイテム登録できない時' do
    it 'ログインしていないユーザーはアイテム登録できない' do
      # トップページに遷移する
      visit root_path
      
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('アイテム登録')
    end
  end
end

RSpec.describe 'アイテム編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end

  context 'アイテム編集ができるとき' do
    it 'ログインしたユーザーはアイテム編集ができる' do
      # ユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
      
      # アイテム詳細ページへ遷移する
      visit item_path(@item)
      
      # 編集ページへのリンクが有ることを確認する
      expect(page).to have_link '編集', href: edit_item_path(@item)
      
      # 編集画面に遷移する
      visit edit_item_path(@item)
      
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(page).to have_field('設備名', with: @item.equipment_name)
      expect(page).to have_field('設備型番', with: @item.equipment_model_number)
      expect(page).to have_field('シリアルナンバー', with: @item.serial_number)
      expect(page).to have_field('消耗品名', with: @item.consumable_name)
      expect(page).to have_field('消耗品型番', with: @item.consumable_model_number)
      expect(page).to have_field('メーカー', with: @item.consumable_maker)
      expect(page).to have_field('点検周期 (日)', with: @item.inspection_interval)
      
      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { Item.count }.by(0)
      
      # トップページにリダイレクトされることを確認する
      expect(current_path).to eq root_path
      
      # トップページには先ほど変更した内容のアイテムが存在することを確認する
      expect(page).to have_content(@item.equipment_name)
      expect(page).to have_content(@item.equipment_model_number)
      expect(page).to have_content(@item.serial_number)
      expect(page).to have_content(@item.consumable_name)
      expect(page).to have_content(@item.consumable_model_number)
      expect(page).to have_content(@item.consumable_maker)
    end
  end

  context 'アイテム編集ができないとき' do
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページに遷移する
      visit root_path
      # アイテム詳細ページへ遷移する
      visit item_path(@item)
      # 編集ページへのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_item_path(@item)
    end
  end
end

RSpec.describe 'アイテム削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end
  context 'アイテム削除ができるとき' do
    it 'ログインしたユーザーはアイテムの削除ができる' do
      # ユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      # アイテム詳細ページへ遷移する
      visit item_path(@item)
      # アイテムに「削除」へのリンクがあることを確認する
      expect(page).to have_link '削除', href: item_path(@item)
      
      # 「削除」をクリックするとアイテムが削除される
      find_link('削除', href: item_path(@item)).click
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        sleep 1
      }.to change { Item.count }.by(-1)
      
      # トップページにリダイレクトされることを確認する
      expect(current_path).to eq root_path
      # トップページにはアイテムの内容が存在しないことを確認する
      expect(page).not_to have_content(@item.equipment_name)
      expect(page).not_to have_content(@item.equipment_model_number)
      expect(page).not_to have_content(@item.serial_number)
      expect(page).not_to have_content(@item.consumable_name)
      expect(page).not_to have_content(@item.consumable_model_number)
      expect(page).not_to have_content(@item.consumable_maker)
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしていないとアイテムの削除ができない' do
      # トップページに遷移する
      visit root_path
      # アイテム詳細ページへ遷移する
      visit item_path(@item)
      # 編集ページへのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: item_path(@item)
    end
  end
end
