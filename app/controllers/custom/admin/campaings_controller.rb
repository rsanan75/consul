class Admin::CampaingsController < Admin::BaseController
  include Translatable
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
    @campaing.destroy
    redirect_to admin_campaings_path, notice: t("admin.campaings.destroy.notice")
  end

  private

    def campaing_params
      attributes = [:starts_at, :poll_id, :proposal_id, :ends_at, translation_params(Campaing)]

      params.require(:campaing).permit(*attributes)
    end
end
