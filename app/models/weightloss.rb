class Weightloss < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :sleep, presence: true
  validates :faigue, presence: true
end