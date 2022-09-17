require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'バリデーションのテスト' do

    context 'バリデーションが実行されず、正しく実装される場合' do
      it '正しくユーザー情報(nickname,email,password,password_confirmation)が存在すれば登録出来る' do
        expect(@user).to be_valid
      end

      it 'age_idは空でも保存できること' do
        @user.age_id = 1
        expect(@user).to be_valid
      end

      it 'introductionは空でも保存できること' do
        @user.introduction = ''
        expect(@user).to be_valid
      end
    end

    context 'バリデーションが実行され、実装出来ない場合' do
      it 'nicknameが空では登録出来ない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'nicknameが9文字以上では登録出来ない' do
        @user.nickname = 'test12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームは8文字以内で入力してください")
      end

      it 'nicknameが重複している場合は登録出来ない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.nickname = @user.nickname
        another_user.valid?
        expect(another_user.errors.full_messages).to include("ニックネームはすでに存在します")
      end

      it 'emailが空では登録出来ない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it 'emailが重複している場合は登録出来ない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it 'emailに@が含まれていないと登録出来ない' do
        @user.email = 'hogegmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end

      it 'passwordが空では登録出来ない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが5文字以下では登録出来ない' do
        @user.password = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordが半角英数字を含んでいないと登録出来ない' do
        @user.password = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'passwordが半角英字のみだと登録出来ない' do
        @user.password = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'passwordが半角数字のみだと登録出来ない' do
        @user.password = '1111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'passwordとpassword_confirmationが不一致では登録出来ない' do
        @user.password = 'test123'
        @user.password_confirmation = 'test456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it "introductionが200文字以下でなければ登録出来ない" do
        @user.introduction = "a" * 201
        @user.valid?
        expect(@user.errors.full_messages).to include("自己紹介は200文字以内で入力してください")
      end
    end
  end
end
