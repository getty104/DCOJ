class AddContestForeignKeyToQuestions < ActiveRecord::Migration[5.0]
	def change
		add_foreign_key :questions, :contests 
	end
end
