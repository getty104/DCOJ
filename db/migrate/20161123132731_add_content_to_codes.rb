class AddContentToCodes < ActiveRecord::Migration[5.0]
  def change
    add_column :codes, :content, :text
  end
end
