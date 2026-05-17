class CreateQuests < ActiveRecord::Migration[8.0]
  def change
    create_table :quests do |t|
      t.string :title
      t.text :body
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
