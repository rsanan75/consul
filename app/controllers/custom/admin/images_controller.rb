class Admin::CampaingsController::ImagesController < Admin::BaseController
  include Translatable
  before_action :load_campaing, except: :destroy

  def index
  end

  def new
    
  end

  def create
  end

  def destroy
    @image = ::Image.find(params[:id])
    @image.destroy!

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

    def images_params
      attributes = [:starts_at, :proposal_id, :ends_at, translation_params(Campaing),
                    documents_attributes: [:id, :title, :attachment, :cached_attachment,
                                           :user_id, :_destroy]]

      params.require(:campaing).permit(*attributes)
    end
end