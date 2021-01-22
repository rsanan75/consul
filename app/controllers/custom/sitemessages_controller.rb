class SitemessagesController < ApplicationController
  skip_authorization_check :only => [:create, :new]
  def new
    @sitemessage = Sitemessage.new
  end

  def create
    @sitemessage = Sitemessage.new(sitemessage_params)
    if verify_recaptcha(model: @sitemessage)
      if @sitemessage.save
        SitemessagesMailer.contact_email_all(@sitemessage.name, @sitemessage.email, @sitemessage.message).deliver_later
        redirect_to root_path, notice: t("customtext.sitemessages.success_message")
      else
        render :new
      end
    else
      flash.now[:alert] = t("Error on the recaptcha")
    end
  end
  private

  def sitemessage_params
    params.require(:sitemessage).permit(:name,:email,:message)
  end
  
end
