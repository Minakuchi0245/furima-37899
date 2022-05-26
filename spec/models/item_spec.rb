require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品がうまくいく時' do
      it 'item_nameと,item_instruction,category_id,condition_id,shipping_charge_id,shipping_area_id,shipping_days_id,price,imageが存在すれば登録できる' do
        expect(@item).to be_valid
      end

      it 'priceが半角数値、300以上、9,999,999以下であれば登録できる' do
        @item.price = '300'
        expect(@item).to be_valid
      end

      it 'priceが半角数値、300以上、9,999,999以下であれば登録できる' do
        @item.price = '9999999'
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかない時' do
      it 'item_nameが空だと登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'item_instructionが空だと登録できない' do
        @item.item_instruction = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'category_idが空だと登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください", "カテゴリーを選択してください")
      end

      it 'condition_idが空だと登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("状態を入力してください", "状態を選択してください")
      end

      it 'shipping_charge_idが空だと登録できない' do
        @item.shipping_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it 'shipping_areaが空だと登録できない' do
        @item.shipping_area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it 'shipping_days_idが空だと登録できない' do
        @item.shipping_days_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it 'priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end

      it 'priceが全角だと登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end

      it 'priceが300以下だと登録できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
      end

      it 'priceが9,999,999以上だと登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
      end

      it 'priceが小数点だと登録できない' do
        @item.price = '300.33'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は整数で入力してください')
      end

      it 'imageが空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end

      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("状態を選択してください")
      end

      it '発送料の負担に「---」が選択されている場合は出品できない' do
        @item.shipping_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end

      it '発送元の地域に「---」が選択されている場合は出品できない' do
        @item.shipping_area_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end

      it '発送までの日数にに「---」が選択されている場合は出品できない' do
        @item.shipping_days_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end

      it 'user_idが紐づいてなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
