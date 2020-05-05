class AddProposalWinningproposaltextToCampaings < ActiveRecord::Migration[5.0]
  def change
	  add_reference :campaings, :proposal, foreign_key: true
  end
  def up
    Campaing.add_translation_fields! :win_proposal_text => :text
  end
  def down
    remove_column :campaing_translations, :win_proposal_text
  end
end
