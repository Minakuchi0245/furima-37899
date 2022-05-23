class Shipping < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefectures
  belongs_to :purchase
end
