class Campaing < ApplicationRecord
  translates :title, touch: true
  translates :description, touch: true
  include Globalizable
  include Measurable

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :check_dates, if: -> { starts_at && ends_at }
  validates_translation :title, presence: true, length: { in: 4..Campaing.title_max_length }

  private

    def check_dates
      if ends_at < starts_at
        errors.add(:starts_at, I18n.t("activerecord.errors.models.campaing.attributes.starts_at.range"))
      end
    end
end
