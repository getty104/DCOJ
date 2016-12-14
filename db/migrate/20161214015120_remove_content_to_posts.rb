class RemoveContentToPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :content, :text
  end
end
