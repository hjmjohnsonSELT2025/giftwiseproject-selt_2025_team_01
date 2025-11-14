class CreateRecipients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipients do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :occupation
      t.text :hobbies
      t.text :likes
      t.text :dislikes

      t.timestamps
    end
  end
end
