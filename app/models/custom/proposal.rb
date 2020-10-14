require_dependency Rails.root.join("app", "models", "proposal").to_s

Proposal.class_eval do
  belongs_to :campaing
  has_many :campaings
  
  scope :from_current_campaigns, -> { joins(:campaing).merge(Campaing.current) }
  validates :campaing_id, presence: true
  def editable_by?(user)
    (user&.administrator?) && editable?
  end
end
