class AddForContestToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :for_contest, :boolean
  end
end
