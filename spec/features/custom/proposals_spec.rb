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

  context "Show" do
    let!(:current_campaign) { create(:campaing, starts_at: 1.day.ago, ends_at: 1.day.from_now) }

    scenario "Should show proposal campaing information" do
      proposal = create(:proposal)
      login_as(proposal.author)
      visit proposal_path(proposal)

      expect(page).to have_content proposal.campaing.title
    end
  end

  context "create" do
    let!(:current_campaign1) { create(:campaing, starts_at: 1.day.ago, ends_at: 1.day.from_now) }
    let!(:current_campaign2) { create(:campaing, starts_at: 1.day.ago, ends_at: 1.day.from_now) }

    before do
      author = create(:user)
      login_as(author)
    end

    scenario "Should allow user to choose a campaing between the active ones" do
      visit new_proposal_path

      select current_campaign1.title, from: "proposal_campaing_id"
      fill_in "Proposal title", with: "Help refugees"
      fill_in "Proposal summary", with: "In summary, what we want is..."
      fill_in "Proposal text", with: "This is very important because..."
      fill_in "proposal_video_url", with: "https://www.youtube.com/watch?v=yPQfcG-eimk"
      fill_in "proposal_responsible_name", with: "Isabel Garcia"
      fill_in "proposal_tag_list", with: "Refugees, Solidarity"
      check "proposal_terms_of_service"
      click_button "Create proposal"

      expect(page).to have_content "Proposal created successfully."
    end

    scenario "Should show validation error when user does not select any campaing" do
      visit new_proposal_path

      fill_in "Proposal title", with: "Help refugees"
      fill_in "Proposal summary", with: "In summary, what we want is..."
      fill_in "Proposal text", with: "This is very important because..."
      fill_in "proposal_video_url", with: "https://www.youtube.com/watch?v=yPQfcG-eimk"
      fill_in "proposal_responsible_name", with: "Isabel Garcia"
      fill_in "proposal_tag_list", with: "Refugees, Solidarity"
      check "proposal_terms_of_service"
      click_button "Create proposal"

      expect(page).not_to have_content "Proposal created successfully."
      expect(page).to have_content "can't be blank"
    end
  end

  context "update" do
    let!(:current_campaign) { create(:campaing, starts_at: 1.day.ago, ends_at: 1.day.from_now) }

    scenario "Should allow user to choose a campaing between the active ones" do
      proposal = create(:proposal)
      login_as(proposal.author)
      visit edit_proposal_path(proposal)

      select current_campaign.title, from: "proposal_campaing_id"
      click_button "Save changes"

      expect(page).to have_content "Proposal updated successfully."
    end
  end
end
