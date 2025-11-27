class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :age
      t.string :occupation
      t.text :hobbies
      t.text :likes
      t.text :dislikes

      t.timestamps
    end
  end
end
