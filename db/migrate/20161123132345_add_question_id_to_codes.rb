class AddQuestionIdToCodes < ActiveRecord::Migration[5.0]
  def change
    add_column :codes, :question_id, :integer
  end
end
