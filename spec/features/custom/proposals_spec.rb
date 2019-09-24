# coding: utf-8
require "rails_helper"

describe "Proposals" do

  context "Index" do

    context "Campaings" do
      let(:past_campaign)    { create(:campaing, starts_at: 1.year.ago, ends_at: 1.day.ago.beginning_of_day) }
      let(:current_campaign) { create(:campaing, starts_at: 1.day.ago, ends_at: 1.day.from_now) }
      let(:future_campaign)  { create(:campaing, starts_at: 1.day.from_now, ends_at: 1.year.from_now) }

      let!(:past_proposal)   { create(:proposal, campaing: past_campaign) }
      let!(:current_proposal){ create(:proposal, campaing: current_campaign) }
      let!(:future_proposal) { create(:proposal, campaing: future_campaign) }

      scenario "Should show only currently active campaings" do
        visit proposals_path

        expect(page).not_to have_content(past_campaign.title)
        expect(page).not_to have_content(past_campaign.description)
        expect(page).to have_content(current_campaign.title)
        expect(page).to have_content(current_campaign.description)
        expect(page).to have_link("Go to campaign", count: 1)
        expect(page).not_to have_content(future_campaign.title)
        expect(page).not_to have_content(future_campaign.description)
      end

      scenario "Should show only proposals from currently active campaings" do
        visit proposals_path

        expect(page).not_to have_content(past_proposal.title)
        expect(page).to have_content(current_proposal.title)
        expect(page).not_to have_content(future_proposal.title)
      end
    end
  end

end
