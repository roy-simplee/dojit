class AddEmailPermissionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email_favorites, :boolean, default: true
  end
end
