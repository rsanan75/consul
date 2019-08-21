class Admin::SitemessagesController < Admin::BaseController

  def index
    @sitemessages = Sitemessage.order(created_at: :desc).page params[:page]
    respond_to do |format|
      format.html
      format.csv { send_data @sitemessages.to_csv }
    end
  end


end
