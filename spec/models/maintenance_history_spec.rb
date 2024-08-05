require 'rails_helper'

RSpec.describe MaintenanceHistory, type: :model do
  before do
    @company = FactoryBot.create(:company)
    @maintenance_history = FactoryBot.build(:maintenance_history)
  end

  describe '点検記録登録' do
    context '登録できる時' do
      it 'すべての項目が正しく入力されていれば登録できること' do
        expect(@maintenance_history).to be_valid
      end
    end

    context '登録できない時' do
      it '点検作業日が必要であること' do
        @maintenance_history.exchange_date = " "
        @maintenance_history.valid?
        expect(@maintenance_history.errors.full_messages).to include("Exchange date can't be blank")
      end
      it '次回点検作業日が必要であること' do
        @maintenance_history.next_maintenance_day = " "
        @maintenance_history.valid?
        expect(@maintenance_history.errors.full_messages).to include("Next maintenance day can't be blank")
      end
      it '作業者が必要であること' do
        @maintenance_history.worker = nil
        @maintenance_history.valid?
        expect(@maintenance_history.errors.full_messages).to include("Worker can't be blank")
      end
      it 'コメントが必要であること' do
        @maintenance_history.maintenance_comment = " "
        @maintenance_history.valid?
        expect(@maintenance_history.errors.full_messages).to include("Maintenance comment can't be blank")
      end
    end
  end
end
