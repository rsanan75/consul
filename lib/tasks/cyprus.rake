namespace :cyprus do
  desc "For all the cyprus related tsks"
  task retire_propsals_not_appropriate: :environment do 
    Campaing.where(":date >= ends_at", date: Time.current).each do |campaing|
      Proposal.not_retired.where(":campaing_id = campaing_id",campaing_id: campaing.id).each do |proposal|
        proposal.retired_at = Time.current
        proposal.retired_reason = "Retiring Proposal as " + campaing.title + " expired."
        proposal.retired_explanation = "Retiring Proposal as " + campaing.title + " expired."
        proposal.save(validate: false)
        print proposal.retired_at
        print "\n"
      end
    end
  end
end