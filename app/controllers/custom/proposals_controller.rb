require_dependency "#{Rails.root}/app/controllers/proposals_controller"

ProposalsController.class_eval do
  before_action :set_campaings, only: :index

  def index
    @resources = resource_model.all
    if params[:retired].present?
      @resources = resource_model.all.retired
    else 
      @resources = @resources.from_current_campaigns
    end
    if params[:retired].present?
      @campaigns = Campaing.where(":date >= ends_at", date: Time.current).order(ends_at: :desc)
      i = 0
      arr = []
      @campaigns.each do |campaing|
        if campaing.proposal_id.present?
          arr.push(campaing.proposal_id)
        end
        if i == 0
            
          logger.debug "campaing : #{@campaing.attributes.inspect}"
          if campaing.documents.present?
            campaing.documents.each do |document|
              logger.debug "the docuemnt: #{document.inspect}"
              logger.debug "the language: #{I18n.locale.inspect}"
              if I18n.locale == document.title
                @campaign_document = document.attachment.url
              end
            end
          end
        end
        i += 1
      end
      @all_winning_proposals = Proposal.where(id: arr)
    else 
      @campaigns = Campaing.current.order(ends_at: :desc)
    end
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
    @remote_translations = detect_remote_translations(@resources, featured_proposals, @campaigns)

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
      if params[:retired].present?
        @campaigns = Campaing.where(":date >= ends_at", date: Time.current).order(ends_at: :desc)
      else 
        @campaigns = Campaing.current.order(ends_at: :desc)
      end
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
