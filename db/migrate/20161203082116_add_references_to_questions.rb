class AddReferencesToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_reference :questions, :created_user
  end
end
