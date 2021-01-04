class AddShowVotesToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :show_votes, :boolean
  end
end
