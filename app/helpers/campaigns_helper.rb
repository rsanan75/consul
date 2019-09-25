module CampaignsHelper
  def campaing_select_options
    Campaing.current.collect { |campaing| [campaing.title, campaing.id] }
  end
end
