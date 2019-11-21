class SitemessagesController < ApplicationController
  skip_authorization_check :only => [:create, :new]
  def new
    @sitemessage = Sitemessage.new
  end

  def create
    @sitemessage = Sitemessage.new(sitemessage_params)
    if @sitemessage.save
      SitemessagesMailer.contact_email(@sitemessage).deliver_later
      redirect_to root_path, notice: "Thanks for your message! We will get back to you."
    else
      render :new
    end
  end
  private

  def sitemessage_params
    params.require(:sitemessage).permit(:name,:email,:message)
  end
  
end
