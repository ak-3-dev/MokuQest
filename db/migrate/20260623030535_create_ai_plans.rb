class CreateAiPlans < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.text :goal
      t.string :period
      t.string :level

      t.timestamps
    end
  end
end
