class SitemessagesController < ApplicationController
  skip_authorization_check :only => [:create, :new]
  def new
    @sitemessage = Sitemessage.new
  end

  def create
    @sitemessage = Sitemessage.new(sitemessage_params)
    @recaptcha_succeeded = verify_recaptcha(model: @sitemessage)
    if @recaptcha_succeeded && @sitemessage.save
      SitemessagesMailer.contact_email_all(@sitemessage.name, @sitemessage.email, @sitemessage.message).deliver_later
      redirect_to root_path, notice: t("customtext.sitemessages.success_message")
    else
      render :new
    end
  end
  private

  def sitemessage_params
    params.require(:sitemessage).permit(:name,:email,:message)
  end
  
end
