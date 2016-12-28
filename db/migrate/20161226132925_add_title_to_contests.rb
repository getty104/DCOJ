class AddTitleToContests < ActiveRecord::Migration[5.0]
  def change
    add_column :contests, :title, :string
  end
end
