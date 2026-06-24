class AiPlan < ApplicationRecord
  belongs_to :user

  has_many :ai_tasks, dependent: :destroy
end
