class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.timestamps
      t.references :created_user, index: true
      t.foreign_key :questions, :users, column: :created_user_id
    end
  end

end
