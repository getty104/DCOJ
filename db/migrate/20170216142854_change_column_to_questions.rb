class ChangeColumnToQuestions < ActiveRecord::Migration[5.0]
  def change
  	 change_column :questions, :for_contest, :integer, null: false
  end
end
