class ChangeDataTypeOfInputAndOutputToQuestions < ActiveRecord::Migration[5.0]
  def change
  	change_column :questions, :input, :text
  	change_column :questions, :output, :text
  end
end
