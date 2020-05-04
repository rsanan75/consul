class CampaingsController < ApplicationController
  load_and_authorize_resource
  if params[:retired].present?
    @poll = Campaing.poll_id
    @proposal = Campaing.proposal_id
  else 
    
  end
end
