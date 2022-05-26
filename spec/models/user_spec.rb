require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいく時' do
      it 'nicknameとemail,password,password_confiramation,last_name,first_name,lats_name_kana,first_name_kana,birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上の半角英数字混合であれば登録できる' do
        @user.password = 'abcd1234'
        @user.password_confirmation = 'abcd1234'
        expect(@user).to be_valid
      end

      it 'last_nameが全角であれば登録できる' do
        @user.last_name = 'あああ'
        expect(@user).to be_valid
      end

      it 'first_nameが全角であれば登録できる' do
        @user.first_name = 'あああ'
        expect(@user).to be_valid
      end

      it 'last_name_kanaが全角カナであれば登録できる' do
        @user.first_name_kana = 'アアア'
        expect(@user).to be_valid
      end

      it 'first_name_kanaが全角カナであれば登録できる' do
        @user.first_name_kana = 'アアア'
        expect(@user).to be_valid
      end
    end

    context '新規登録が上手くいかない時' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailには@が含まれていないと登録できない' do
        @user.email = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'passwordとconfirmが一致していないと登録できない' do
        @user.password = 'abcd1234'
        @user.password_confirmation = 'abcd123'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'abcd1'
        @user.password_confirmation = 'abcd1'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは無効です 英字と数字の両方を含めてください')
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは無効です 英字と数字の両方を含めてください')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ああああああ'
        @user.password_confirmation = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは無効です 英字と数字の両方を含めてください')
      end

      it 'passwordは英数字混合でないと登録できない' do
        @user.password = '1234567'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは無効です 英字と数字の両方を含めてください')
      end

      it 'last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end

      it 'last_nameが全角入力でなければ登録できないこと' do
        @user.last_name = 'ｱｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は無効です 全角で入力してください')
      end

      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it 'first_nameが全角入力でなければ登録できないこと' do
        @user.first_name = 'ｱｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は無効です 全角で入力してください')
      end

      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（カタカナ）を入力してください")
      end

      it 'last_name_kanaが全角入力でなければ登録できないこと' do
        @user.last_name_kana = 'ｱｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（カタカナ）は無効です カタカナで入力してください')
      end

      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カタカナ）を入力してください")
      end

      it 'first_name_kanaが全角入力でなければ登録できないこと' do
        @user.first_name_kana = 'ｱｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カタカナ）は無効です カタカナで入力してください')
      end

      it 'birth_dateが空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
