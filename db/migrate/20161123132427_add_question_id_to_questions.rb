class AddQuestionIdToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :question_id, :integer
  end
end
