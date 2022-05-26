require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができる時' do
      it '全ての配送先情報が存在すれば登録できる' do
        expect(@purchase_shipping).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @purchase_shipping.building_name = ''
        expect(@purchase_shipping).to be_valid
      end

      it '郵便番号が[3桁-4桁]の組み合わせであれば保存できる' do
        @purchase_shipping.postal_code = '123-4567'
        expect(@purchase_shipping).to be_valid
      end

      it '電話番号が11桁かつハイフンなしであれば保存できる' do
        @purchase_shipping.telephone = '12345678912'
        expect(@purchase_shipping).to be_valid
      end

      it '電話番号が10桁かつハイフンなしであれば保存できる' do
        @purchase_shipping.telephone = '1234567891'
        expect(@purchase_shipping).to be_valid
      end
    end

    context '配送先情報の保存ができない時' do
      it 'user_idが空だと保存できない' do
        @purchase_shipping.user_id = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Userを入力してください")
      end

      it 'item_idが空だと保存できない' do
        @purchase_shipping.item_id = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Itemを入力してください")
      end

      it '郵便番号が空だと保存できないこと' do
        @purchase_shipping.postal_code = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("郵便番号を入力してください",
                                                                   '郵便番号は無効です ハイフン(-)を含めてください')
      end

      it '郵便番号にハイフンがないと保存できないこと' do
        @purchase_shipping.postal_code = '1234567'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('郵便番号は無効です ハイフン(-)を含めてください')
      end

      it '郵便番号が全角だと保存できないこと' do
        @purchase_shipping.postal_code = '１２３４-５６７'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('郵便番号は無効です ハイフン(-)を含めてください')
      end

      it '都道府県が「---」だと保存できないこと' do
        @purchase_shipping.prefectures_id = '1'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("都道府県を選択してください")
      end

      it '市区町村が空だと保存できないこと' do
        @purchase_shipping.city = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("市区町村を入力してください")
      end

      it '番地が空だと保存できないこと' do
        @purchase_shipping.address = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("番地を入力してください")
      end

      it '電話番号が空だと保存できないこと' do
        @purchase_shipping.telephone = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("電話番号を入力してください")
      end

      it '電話番号にハイフンがあると保存できないこと' do
        @purchase_shipping.telephone = '090-1234-5678'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('電話番号は10桁or11桁の数値を入力してください')
      end

      it '電話番号が9桁以下だと保存できないこと' do
        @purchase_shipping.telephone = 123_456_789
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('電話番号は10桁or11桁の数値を入力してください')
      end

      it '電話番号が12桁以上あると保存できないこと' do
        @purchase_shipping.telephone = 123_456_789_123
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('電話番号は10桁or11桁の数値を入力してください')
      end

      it 'トークンが空だと保存できないこと' do
        @purchase_shipping.token = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
