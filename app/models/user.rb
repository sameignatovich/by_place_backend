class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password
  has_many :tokens, dependent: :destroy

  validates :fullname, presence: true, length: { in: 5..64 }
  validates :username, presence: true, uniqueness: { message: 'имя пользователя уже занято' }, length: { in: 4..24 }
  validates :email, presence: true, uniqueness: { message: 'адрес уже используется' }, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
end
