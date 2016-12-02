class AddCreatedUserToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_reference :questions, :created_user, foreign_key: true
  end
end
