require 'rails_helper'

RSpec.describe Item, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'アイテム新規登録' do
    context '新規登録できる時' do
      it 'すべての項目が正しく入力されていれば登録できること' do
        expect(@item).to be_valid
      end
    end

    context '新規登録できない時' do
      it '消耗品名が必要であること' do
        @item.consumable_name = " "
        @item.valid?
        expect(@item.errors.full_messages).to include("Consumable name can't be blank")
      end

      it '消耗品モデル番号が必要であること' do
        @item.consumable_model_number = " "
        @item.valid?
        expect(@item.errors.full_messages).to include("Consumable model number can't be blank")
      end

      it '消耗品のメーカー名が必要であること' do
        @item.consumable_maker = " "
        @item.valid?
        expect(@item.errors.full_messages).to include("Consumable maker can't be blank")
      end

      it '装置名が必要であること' do
        @item.equipment_name = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Equipment name can't be blank")
      end

      it '装置のモデルナンバーが必要であること' do
        @item.equipment_model_number = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Equipment model number can't be blank")
      end

      it 'シリアル番号が必要であること' do
        @item.serial_number = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Serial number can't be blank")
      end

      it '点検間隔が必要であること' do
        @item.inspection_interval = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Inspection interval can't be blank")
      end

      it '開始日が必要であること' do
        @item.start_date = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Start date can't be blank")
      end
    end
  end
end
