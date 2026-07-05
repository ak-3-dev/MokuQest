class AddStartedOnToAiPlans < ActiveRecord::Migration[8.0]
  def change
    add_column :ai_plans, :started_on, :date
  end
end
