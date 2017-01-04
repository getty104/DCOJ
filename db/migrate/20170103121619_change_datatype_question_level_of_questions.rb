class ChangeDatatypeQuestionLevelOfQuestions < ActiveRecord::Migration[5.0]
  def change
    change_column :questions, :question_level, :decimal
  end
end
