class AddCurrentDayToAiPlans < ActiveRecord::Migration[8.0]
  def change
    add_column :ai_plans, :current_day, :integer, default: 1
  end
end
