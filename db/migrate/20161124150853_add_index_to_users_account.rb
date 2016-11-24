class AddIndexToUsersAccount < ActiveRecord::Migration[5.0]
  def change
  	 add_index :users, :account, unique: true
  end
end
