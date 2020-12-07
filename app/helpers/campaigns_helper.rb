module CampaignsHelper
  def campaing_select_options
    if current_user&.administrator?
      Campaing.collect { |campaing| [campaing.title, campaing.id] }
    else
      Campaing.current.collect { |campaing| [campaing.title, campaing.id] }
    end

    
  end
end
