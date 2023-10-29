class Weightloss < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :weight, presence: true, format: { with: /\A\d+(\.\d{1})?\z/, message: "は正しい形式で入力してください。" }
  validates :sleep, presence: true
  validates :faigue, presence: true

  def start_time
    created_at
  end
end