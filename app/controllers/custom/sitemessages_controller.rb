class SitemessagesController < ApplicationController
  skip_authorization_check :only => [:create, :show]
  def create
    @sitemessage = Sitemessage.new(params[:sitemessage])
    if @sitemessage.save
      redirect_to root_path
    end
  end
  def show
    @sitemessage = Sitemessage.new
  end
end
