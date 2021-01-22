class SitemessagesController < ApplicationController
  include Recaptcha::Verify

  before_action :verify_recaptcha, only: [:create]
  skip_authorization_check :only => [:create, :new]

  def new
    @sitemessage = Sitemessage.new
  end

  def create
    @sitemessage = Sitemessage.new(sitemessage_params)
    
    if @sitemessage.save
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

  def verify_recaptcha
    response = Recaptcha.verify(params)
    session[:sitemessage] = params[:sitemessage].except(:name,:email,:message, :remoteip)
    if verify_recaptcha
    else
      redirect_to new_sitemessage_path(sitemessage: params[:sitemessage]),
      alert: :recaptcha_error
    end
   
  end
end
