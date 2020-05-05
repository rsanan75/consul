class AddProposalWinningproposaltextToCampaings < ActiveRecord::Migration[5.0]
  def self.up
    change_table :campaings do |t|
      t.references :proposal, foreign_key: true
    end
    change_table(:campaing_translations) do |t|
      t.text :win_proposal_text
    end
  end
  def self.down
    change_table :campaings do |t|
      t.remove_references :proposal, foreign_key: true
    end
    remove_column :campaing_translations, :win_proposal_text
  end
end
