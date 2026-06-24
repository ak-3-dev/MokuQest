class AddFieldsToQuests < ActiveRecord::Migration[8.0]
  def change
    add_column :quests, :status, :string unless column_exists?(:quests, :status)
    add_column :quests, :due_date, :date unless column_exists?(:quests, :due_date)
  end
end
