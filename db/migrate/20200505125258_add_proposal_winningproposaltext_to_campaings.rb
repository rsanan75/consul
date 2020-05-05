class AddProposalWinningproposaltextToCampaings < ActiveRecord::Migration[5.0]
  def change
	  add_reference :campaings, :proposal, foreign_key: true
  end
  def self.up
    change_table(:campaing_translations) do |t|
      t.text :win_proposal_text
    end
  end
  def self.down
    remove_column :campaing_translations, :win_proposal_text
  end
end
