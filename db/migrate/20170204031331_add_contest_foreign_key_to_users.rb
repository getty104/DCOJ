class AddContestForeignKeyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :users, :contests, :column => "joined_contest_id"
  end
end



