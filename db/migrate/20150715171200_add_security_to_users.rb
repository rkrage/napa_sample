class AddSecurityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :locked, :boolean, default: false, null: false
    add_column :users, :revoke_date, :datetime
  end
end
