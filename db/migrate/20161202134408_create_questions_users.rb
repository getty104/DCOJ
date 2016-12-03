class CreateQuestionsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_users do |t|
      t.integer :question_id 
      t.integer :user_id
    end
    add_foreign_key :questions, :users
    add_foreign_key :users, :questions
  end
end
