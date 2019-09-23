# coding: utf-8
require "rails_helper"

describe Campaing do
  let(:campaing) { build(:campaing) }

  it "Should be valid" do
    expect(campaing).to be_valid
  end

  it "Should not be valid without a title" do
    campaing.title = nil

    expect(campaing).not_to be_valid
  end

  it "Should not be valid when title exceds 80 characters" do
    campaing.title = "a" * 81

    expect(campaing).not_to be_valid
  end

  it "Should not be valid without a starts_at defined" do
    campaing.starts_at = nil

    expect(campaing).not_to be_valid
  end

  it "Should not be valid without a ends_at defined" do
    campaing.ends_at = nil

    expect(campaing).not_to be_valid
  end

  it "Should not be valid when starts_at date is greater than ends_at" do
    campaing.starts_at = Time.current + 1.day
    campaing.ends_at = Time.current - 1.day

    expect(campaing).not_to be_valid
  end

  describe ".current" do
    it "Should return only active campaings" do
      active_campaign = create(:campaing, starts_at: 1.week.ago, ends_at: 1.week.from_now)
      past_campaign = create(:campaing, starts_at: 1.year.ago, ends_at: 6.months.ago)
      future_campaign = create(:campaing, starts_at: 1.year.from_now, ends_at: 2.years.from_now)

      expect(described_class.current).to eq([active_campaign])
    end
  end
end
