class AiPlan < ApplicationRecord
  belongs_to :user
  belongs_to :quest

  has_many :ai_tasks, dependent: :destroy

  def completed_days_count
    ai_tasks
      .group(:day)
      .having("COUNT(*) = SUM(CASE WHEN completed = 1 THEN 1 ELSE 0 END)")
      .count
      .size
  end
end
