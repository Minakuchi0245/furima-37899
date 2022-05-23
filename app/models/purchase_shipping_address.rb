class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id 

  with_options presence: true do
    validates :user_id
    validates :item_id
  end


  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
  end
  
end
