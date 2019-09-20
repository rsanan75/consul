# coding: utf-8
require "rails_helper"

describe Proposal do
  let(:proposal) { build(:proposal) }

  it "Should not be valid without campaing" do
    proposal.campaing = nil

    expect(proposal).not_to be_valid
  end
end
