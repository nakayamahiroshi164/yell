class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :weightlosses
  has_many :comments
       
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6, maximum: 30 }
  validates :password_confirmation, presence: true, length: { minimum: 6, maximum: 30 }
end
