class UpdateRecipientsFields < ActiveRecord::Migration[7.1]
  def change
    add_column :recipients, :age, :integer
    add_column :recipients, :relationship, :string
    add_column :recipients, :hobbies, :text
    add_column :recipients, :dislikes, :text

    # btw of you're wondering what's the difference between type :string and :text,
    # string --> short, indexed, limited (typically 255 chars).
    # text --> long, unbounded, meant for paragraphs or multi-sentence content.

    remove_column :recipients, :description, :text
  end
end
