class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @users = User.by_username_email_or_document_number(params[:search]) if params[:search]
    
    respond_to do |format|
      format.html
      format.js
      format.csv
    end
  end
end
