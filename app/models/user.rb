class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :items
  has_many :purchases

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,   presence: true
  validates :birth_date, presence: true

  with_options presence: true,
               format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は無効です 全角で入力してください' } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true,
               format: { with: /\A[ァ-ヶ一-]+\z/, message: 'は無効です カタカナで入力してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  encrypted_password = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: encrypted_password, message: 'は無効です 英字と数字の両方を含めてください'
end
