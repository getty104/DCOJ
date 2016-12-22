class RemoveAttributeToPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :attribute, :integer
  end
end
