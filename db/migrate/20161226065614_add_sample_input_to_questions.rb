class AddSampleInputToQuestions < ActiveRecord::Migration[5.0]
	def change
		add_column :questions, :sample_input, :text
	end
end
