class Admin::CampaingsController::ImagesController < Admin::BaseController
  include Translatable
  include ImageAttributes
  load_and_authorize_resource

  def index
  end

  def create
    @campaing = Campaing.new(campaing_params)
    
    if @campaing.save
      redirect_to admin_campaings_path, notice: t("admin.campaings.create.notice")
    else
      render :new
    end
  end

  def update
    if @campaing.update(campaing_params)
      redirect_to admin_campaings_path, notice: t("admin.campaings.update.notice")
    else
      render :edit
    end
  end

  def destroy
    @image = ::Image.find(params[:id])
    @image.destroy!
    @campaing.destroy
    redirect_to admin_campaings_path, notice: t("admin.campaings.destroy.notice")
  end

  private

    def campaing_params
      attributes = [:starts_at, :proposal_id, :ends_at, translation_params(Campaing),
                    images_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy],
                    documents_attributes: [:id, :title, :attachment, :cached_attachment,
                                           :user_id, :_destroy]]

      params.require(:campaing).permit(*attributes)
    end
end
