class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefectures_id, :city, :address, :building_name, :telephone, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :prefectures_id
    validates :city
    validates :address
    validates :telephone
    validates :token
  end

  validates :prefectures_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は無効です ハイフン(-)を含めてください' }
  validates :telephone,
            format: { with: /\A[0-9]+\z/, with: /\A\d{10,11}\z/, message: 'は10桁or11桁の数値を入力してください' }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Shipping.create(postal_code: postal_code, prefectures_id: prefectures_id, city: city, address: address,
                    building_name: building_name, telephone: telephone, purchase_id: purchase.id)
  end
end
