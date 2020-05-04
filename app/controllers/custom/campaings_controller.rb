class CampaingsController < ApplicationController
  load_and_authorize_resource
  def show
    @all_proposals = Proposal.where(campaing_id: @campaing.id)
    @winning_proposal = Proposal.where(id: @campaing.proposal_id)
    @poll = Poll.where(id: @campaing.poll_id)
  end
end
