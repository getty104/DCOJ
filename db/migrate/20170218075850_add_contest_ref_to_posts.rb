class AddContestRefToPosts < ActiveRecord::Migration[5.0]
  def change
		add_reference :posts, :contest
  end
end
