class CreateQuestionsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_users, id: false do |t|
      t.references :user, index: true
      t.references :question, index: true
      t.foreign_key :users
      t.foreign_key :questions
    end
  end
end
