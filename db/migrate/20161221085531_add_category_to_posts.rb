class AddCategoryToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :category, :integer
  end
end
