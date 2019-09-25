# coding: utf-8
require "rails_helper"

describe Proposal do
  let(:proposal) { build(:proposal) }

  it "Should not be valid without campaing" do
    proposal.campaing = nil

    expect(proposal).not_to be_valid
  end

  describe ".from_current_campaigns" do
    let(:past_campaign)    { create(:campaing, starts_at: 1.year.ago, ends_at: 1.day.ago.beginning_of_day) }
    let(:current_campaign) { create(:campaing, starts_at: 1.day.ago, ends_at: 1.day.from_now) }
    let(:future_campaign)  { create(:campaing, starts_at: 1.day.from_now, ends_at: 1.year.from_now) }

    let!(:past_proposal)   { create(:proposal, campaing: past_campaign) }
    let!(:current_proposal){ create(:proposal, campaing: current_campaign) }
    let!(:future_proposal) { create(:proposal, campaing: future_campaign) }

    it "Should return only proposals from currently active campaigns" do
      expect(described_class.from_current_campaigns).not_to include(past_proposal)
      expect(described_class.from_current_campaigns).to include(current_proposal)
      expect(described_class.from_current_campaigns).not_to include(future_proposal)
    end
  end
end
