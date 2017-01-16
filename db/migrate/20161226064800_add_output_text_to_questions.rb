class AddOutputTextToQuestions < ActiveRecord::Migration[5.0]
	def change
		add_column :questions, :output_text, :text
	end
end
