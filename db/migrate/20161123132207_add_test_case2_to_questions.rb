class AddTestCase2ToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :test_case2, :text
  end
end
