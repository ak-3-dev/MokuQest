class Quest < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :ai_plan, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
