class AddDayToAiTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :ai_tasks, :day, :integer
  end
end
