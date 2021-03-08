class SitemessagesController < ApplicationController
  skip_authorization_check :only => [:create, :new]
  def new
    @sitemessage = Sitemessage.new
  end

  def create
	  #abort params.inspect
	 status = verify_google_recptcha('6LcTZDcaAAAAAKSJqrzdGH1Okn5RqciXnQEEvJUS',params["g-recaptcha-response"])
    @sitemessage = Sitemessage.new(sitemessage_params)
    
    if @sitemessage.save and verify_recaptcha
      SitemessagesMailer.contact_email_all(@sitemessage.name, @sitemessage.email, @sitemessage.message).deliver_later
      redirect_to root_path, notice: t("customtext.sitemessages.success_message")
    else
      render :new
    end
  end
  private
  
  def verify_google_recptcha(secret_key,response)
	    status = 'curl "https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{response}"'
	        logger.info "---------------status ==> #{status}"
		    hash = JSON.parse(status)
		        hash["success"] == true ? true : false
  end
  def sitemessage_params
    params.require(:sitemessage).permit(:name,:email,:message)
  end
  
end
