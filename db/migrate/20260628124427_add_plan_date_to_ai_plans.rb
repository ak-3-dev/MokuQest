class AddPlanDateToAiPlans < ActiveRecord::Migration[8.0]
  def change
    add_column :ai_plans, :plan_date, :date
  end
end
