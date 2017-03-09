class AddOriginLevelToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :origin_level, :integer
  end
end
