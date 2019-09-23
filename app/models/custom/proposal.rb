require_dependency Rails.root.join("app", "models", "proposal").to_s

Proposal.class_eval do
  belongs_to :campaing

  validates :campaing, presence: true
end
