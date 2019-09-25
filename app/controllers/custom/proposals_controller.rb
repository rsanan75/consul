require_dependency "#{Rails.root}/app/controllers/proposals_controller"

ProposalsController.class_eval do
  before_action :set_campaings, only: :index

  def index
    @resources = resource_model.all
    @resources = @resources.from_current_campaigns
    @resources = @current_order == "recommendations" && current_user.present? ? @resources.recommendations(current_user) : @resources.for_render
    @resources = @resources.search(@search_terms) if @search_terms.present?
    @resources = @advanced_search_terms.present? ? @resources.filter(@advanced_search_terms) : @resources
    @resources = @resources.tagged_with(@tag_filter) if @tag_filter
    resources_csv = @resources

    @resources = @resources.page(params[:page]).send("sort_by_#{@current_order}")

    index_customization

    @tag_cloud = tag_cloud
    @banners = Banner.in_section(section(resource_model.name)).with_active

    set_resource_votes(@resources)

    set_resources_instance
    @remote_translations = detect_remote_translations(@resources, featured_proposals)

    respond_to do |format|
      format.html
      format.csv { send_data to_csv(resources_csv, resource_model),
                            type: "text/csv",
                            disposition: "attachment",
                            filename: "#{get_resource(resource_model)}.csv" }
    end
  end

  private

    def set_campaings
      @campaigns = Campaing.current
    end

    def proposal_params
      attributes = [:video_url, :responsible_name, :tag_list,
                    :terms_of_service, :geozone_id, :skip_map, :campaing_id,
                    image_attributes: image_attributes,
                    documents_attributes: [:id, :title, :attachment, :cached_attachment,
                                           :user_id, :_destroy],
                    map_location_attributes: [:latitude, :longitude, :zoom]]
      translations_attributes = translation_params(Proposal, except: :retired_explanation)
      params.require(:proposal).permit(attributes, translations_attributes)
    end
end
