class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_item, only: [:index, :create]
  before_action :buy_block_logout, :buy_block_user, :buy_block_purchaser

  def index
    @purchase_shipping = PurchaseShipping.new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)

    if @purchase_shipping.valid?
      pay_item
      @purchase_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipping).permit(:postal_code, :prefectures_id, :city, :address, :building_name, :telephone).merge(
      item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def buy_block_user
    redirect_to root_path if current_user.id == @item.user_id
  end

  def buy_block_purchaser
    redirect_to root_path if @item.purchase.present?
  end

  def buy_block_logout
    redirect_to user_session_path unless user_signed_in?
  end
end
