class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      # t.string :email,              null: false, default: ""  # Already exists
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:users, :encrypted_password)

      ## Recoverable
      # t.string   :reset_password_token           # Already exists
      # t.datetime :reset_password_sent_at         # Already exists

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)
    end

    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end