class CreateTestCases < ActiveRecord::Migration[5.0]
  def change
    create_table :test_cases do |t|
      t.text :case
      t.references :question, index: true, null: false
      t.timestamps
    end
  end
end
