class AddTestCase1ToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :test_case1, :text
  end
end
