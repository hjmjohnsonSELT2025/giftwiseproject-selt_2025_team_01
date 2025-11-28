class CreateEventRecipients < ActiveRecord::Migration[7.1]
  def change
    create_table :event_recipients do |t|
      t.references :event, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
