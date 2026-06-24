class AddExpAndLevelToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :exp, :integer, default: 0, null: false
    add_column :users, :level, :integer, default: 1, null: false
  end
end
