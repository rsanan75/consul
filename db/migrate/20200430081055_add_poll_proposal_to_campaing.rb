class AddPollProposalToCampaing < ActiveRecord::Migration[5.0]
  def change
    add_reference :campaings, :poll, foreign_key: true
    add_reference :campaings, :proposal, foreign_key: true
  end
end
