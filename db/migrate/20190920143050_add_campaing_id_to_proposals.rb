class AddCampaingIdToProposals < ActiveRecord::Migration[5.0]
  def change
    add_reference :proposals, :campaing, foreign_key: true
  end
end
