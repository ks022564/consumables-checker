require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @company = FactoryBot.create(:company)
    @user = FactoryBot.build(:user, company: @company)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it 'すべての項目が正しく入力されていれば登録できること' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない時' do
      it '会社名が必要であること' do
        @company.company_name = ' '
        @company.valid?
        expect(@company.errors.full_messages).to include("Company name can't be blank")
      end
      it '名前が必要であること' do
        @user.name = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it 'メールアドレスが入力されていること' do
        @user.email = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'パスワードが入力されていること' do
        @user.password = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、＠を含むこと' do
        @user.email = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードは6文字以上であること' do
        @user.password = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
    context '同じ会社内で同じメールアドレスが存在する場合' do
      it 'ユーザーは無効であること' do
        FactoryBot.create(:user, email: 'test@example.com', company: @company)
        duplicate_user = FactoryBot.build(:user, email: 'test@example.com', company: @company)
        expect(duplicate_user).not_to be_valid
        expect(duplicate_user.errors[:email]).to include('is already taken within this company')
      end
    end

    context '異なる会社で同じメールアドレスが存在する場合' do
      it 'ユーザーは有効であること' do
        another_company = FactoryBot.create(:company, company_name: 'Another Company')
        FactoryBot.create(:user, email: 'test@example.com', company: another_company)
        new_user = FactoryBot.build(:user, email: 'test@example.com', company: @company)
        expect(new_user).to be_valid
      end
    end
  end
end
