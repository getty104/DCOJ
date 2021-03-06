class CreateContests < ActiveRecord::Migration[5.0]
	def change
		create_table :contests do |t|
			t.time :start_time
			t.time :finish_time
			t.references :created_user, null: false, index: true
			t.timestamps
		end
			add_foreign_key :contests, :users, :column => "created_user_id"
	end
end
