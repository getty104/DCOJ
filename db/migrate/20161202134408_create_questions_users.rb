class CreateQuestionsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_users, id: false do |t|
      t.integer :user_id
      t.integer :question_id
      t.foreign_key :users
      t.foreign_key :questions
    end
  end
end
