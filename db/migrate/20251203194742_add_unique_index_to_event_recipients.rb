class AddUniqueIndexToEventRecipients < ActiveRecord::Migration[7.1]
  def change
    # this adds an index to each event-recipient row
    # the purpose of this is to avoid duplicate rows
    add_index :event_recipients, [:event_id, :recipient_id], unique: true
  end
end
