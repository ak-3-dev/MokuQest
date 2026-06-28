class AddQuestToAiPlans < ActiveRecord::Migration[8.0]
  def change
    add_reference :ai_plans, :quest, foreign_key: true
  end
end
