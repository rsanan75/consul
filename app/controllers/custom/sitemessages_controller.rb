class SitemessagesController < ApplicationController
  skip_authorization_check :only => [:create, :new]
  def new
    @sitemessage = Sitemessage.new
  end

  def create
    #abort params.inspect
    abort verify_google_recptcha(Rails.application.secrets.recaptcha_secret_key,params["g-recaptcha-response"]).inspect
	 status = verify_google_recptcha(Rails.application.secrets.recaptcha_secret_key,params["g-recaptcha-response"])
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

    host = "https://www.google.com/recaptcha/api/siteverify"
      path = "/?secret=#{secret_key}&response=#{response}"

      uri = URI(host + path)

      request = Net::HTTP::Get.new(uri)

      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == "https") do |http|
        http.request(request)
      end

      result = response.body.force_encoding("utf-8")

      JSON.parse(result)
  end
  def sitemessage_params
    params.require(:sitemessage).permit(:name,:email,:message)
  end
  
end
