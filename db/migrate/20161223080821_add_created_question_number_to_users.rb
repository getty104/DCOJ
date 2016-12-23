class AddCreatedQuestionNumberToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :created_question_number, :integer
  end
end
