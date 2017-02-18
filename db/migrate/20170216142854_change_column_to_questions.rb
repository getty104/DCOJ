class ChangeColumnToQuestions < ActiveRecord::Migration[5.0]
  def change
  	 change_column :questions, :for_contest, 'integer USING CAST(hoge AS integer)', null: false
  end
end
