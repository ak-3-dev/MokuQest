class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :quest
  
  validates :comment, presence: true
end
