class CampaingsController < ApplicationController
  load_and_authorize_resource
  def show
    @all_proposals = Proposal.where(campaing_id: @campaing.id)
    @winning_proposal = Proposal.find(@campaing.proposal_id).inspect
    @poll = Poll.find(@campaing.poll_id).inspect
  end
end
