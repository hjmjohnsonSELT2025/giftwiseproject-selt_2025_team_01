class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :date
      t.text :description
      t.string :theme
      t.decimal :budget

      t.timestamps
    end
  end
end
