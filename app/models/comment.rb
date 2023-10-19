class Comment < ApplicationRecord
  belongs_to :weightloss   
  belongs_to :user  
  validates :content, presence: true

end
