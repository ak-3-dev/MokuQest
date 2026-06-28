class AiPlan < ApplicationRecord
  belongs_to :user
  belongs_to :quest

  has_many :ai_tasks, dependent: :destroy
end
