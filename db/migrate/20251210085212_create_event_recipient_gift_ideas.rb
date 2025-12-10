class CreateEventRecipientGiftIdeas < ActiveRecord::Migration[7.1]
  def change
    create_table :event_recipient_gift_ideas do |t|
      t.references :event_recipient, null: false, foreign_key: true
      t.string :title, null: false
      t.text :notes
      t.string :url

      t.timestamps
    end
  end
end