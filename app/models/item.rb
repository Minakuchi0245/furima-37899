class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :shipping_area
  belongs_to :shipping_days

  belongs_to :user
  has_one :purchase
  has_one_attached :image

  with_options presence: true do
    validates :item_name
    validates :item_instruction
    validates :category_id
    validates :condition_id
    validates :shipping_charge_id
    validates :shipping_area_id
    validates :shipping_days_id
    validates :price
    validates :image
  end

  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_charge_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_area_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_days_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    format: { with: /\A[0-9]+\z/ }
end
