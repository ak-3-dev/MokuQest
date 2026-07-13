class CreateGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.text :rules
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
