class CampaingsController < ApplicationController
  load_and_authorize_resource
  if params[:retired].present?
    @poll = Campaing.poll
    @proposal = Campaing.proposal
  else 
    
  end
end
