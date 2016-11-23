class AddAccountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :account, :string
  end
end
