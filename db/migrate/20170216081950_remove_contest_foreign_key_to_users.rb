class RemoveContestForeignKeyToUsers < ActiveRecord::Migration[5.0]
	def change
		remove_foreign_key :users, :contests
	end
end
