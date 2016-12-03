class CreateQuestionsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_users do |t|
      t.references :question, foreign_key: true
      t.references :user, foreign_key: true
      t.foreign_key :questions
      t.foreign_key :users
    end
  end
end
