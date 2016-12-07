class AddQuestionLevelToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :question_level, :integer
  end
end
