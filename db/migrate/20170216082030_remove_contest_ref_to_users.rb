class RemoveContestRefToUsers < ActiveRecord::Migration[5.0]
  def change
  	    remove_reference :users, :joined_contest
  end
end
