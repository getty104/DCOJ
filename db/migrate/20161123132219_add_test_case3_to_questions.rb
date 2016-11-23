class AddTestCase3ToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :test_case3, :text
  end
end
