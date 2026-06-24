class AddLevelToUserQuests < ActiveRecord::Migration[8.0]
  def change
    add_column :user_quests, :level, :string
  end
end
