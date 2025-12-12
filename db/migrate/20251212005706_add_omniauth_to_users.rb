class AddOmniauthToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :provider, :string unless column_exists?(:users, :provider)
    add_column :users, :uid, :string unless column_exists?(:users, :uid)
    add_column :users, :avatar_url, :string unless column_exists?(:users, :avatar_url)
    add_column :users, :name, :string unless column_exists?(:users, :name)
  end
end