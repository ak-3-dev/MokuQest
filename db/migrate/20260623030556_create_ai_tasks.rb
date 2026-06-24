class CreateAiTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_tasks do |t|
      t.references :ai_plan, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :exp
      t.boolean :completed

      t.timestamps
    end
  end
end
