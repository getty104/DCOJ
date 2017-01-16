class AddContestRefToQuestions < ActiveRecord::Migration[5.0]
	def change
		add_reference :questions, :contest
	end
end
