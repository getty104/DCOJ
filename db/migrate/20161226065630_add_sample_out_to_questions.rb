class AddSampleOutToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :sample_output, :text
  end
end
