class AddDetailsToQuests < ActiveRecord::Migration[8.0]
  def change
    add_column :quests, :goal, :string
    add_column :quests, :period, :string
    add_column :quests, :motivation, :text
    add_column :quests, :level, :string
  end
end
