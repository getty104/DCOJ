class AddTitleToCodes < ActiveRecord::Migration[5.0]
  def change
    add_column :codes, :title, :string
  end
end
