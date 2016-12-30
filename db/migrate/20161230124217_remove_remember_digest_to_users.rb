class RemoveRememberDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :remember_digest, :string
  end
end
