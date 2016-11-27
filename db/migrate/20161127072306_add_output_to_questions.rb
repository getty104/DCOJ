class AddOutputToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :output, :binary
  end
end
