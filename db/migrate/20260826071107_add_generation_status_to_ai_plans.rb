class AddGenerationStatusToAiPlans < ActiveRecord::Migration[8.0]
  def change
    add_column :ai_plans, 
               :generation_status,
               :string,
               default: "pending",
               null: false
  end
end
