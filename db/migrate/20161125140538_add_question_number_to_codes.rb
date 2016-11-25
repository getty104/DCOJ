class AddQuestionNumberToCodes < ActiveRecord::Migration[5.0]
  def change
    add_column :codes, :question_number, :integer
  end
end
