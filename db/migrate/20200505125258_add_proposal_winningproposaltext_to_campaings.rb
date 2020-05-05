class AddProposalWinningproposaltextToCampaings < ActiveRecord::Migration[5.0]
  def change
	  add_column :campaings, :win_proposal_text, :text
	  add_reference :campaings, :proposal, foreign_key: true
  end
end
