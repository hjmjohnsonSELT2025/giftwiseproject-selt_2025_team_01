class CreateGiftIdeas < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_ideas do |t|
      t.references :recipient, null: false, foreign_key: true
      t.string :title
      t.text :notes
      t.string :url

      t.timestamps
    end
  end
end
