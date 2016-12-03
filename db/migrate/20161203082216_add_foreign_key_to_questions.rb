class AddForeignKeyToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :questions, :users, :column => "created_user_id"
  end
end
