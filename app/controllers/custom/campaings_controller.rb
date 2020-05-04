class CampaingsController < ApplicationController
  load_and_authorize_resource
  def show
    @all_proposals = Proposal.where(id: params(:campaing_id))
  end
end
