class AddInputToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :input, :binary
  end
end
