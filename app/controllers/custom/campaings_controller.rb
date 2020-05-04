class CampaingsController < ApplicationController
  load_and_authorize_resource
  def show
    @all_proposals = Proposal.where(campaing_id: @campaing.id)
    @winning_proposals = []
    @all_proposals.each do |proposal|
      if proposal.id == @campaing.proposal_id
        @winning_proposals += proposal
      end
    end
  end
end
