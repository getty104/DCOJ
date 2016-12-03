class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.timestamps
      t.references :created_user
      t.integer :created_user_id
      t.foreign_key :users, column: :created_user_id
    end
  end
end
