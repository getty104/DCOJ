class AddInputTextToQuestions < ActiveRecord::Migration[5.0]
	def change
		add_column :questions, :input_text, :text
	end
end
