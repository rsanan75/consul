class Campaing < ApplicationRecord
  translates :title, touch: true
  translates :description, touch: true
  translates :win_proposal_text
  translates :report_description
  include Globalizable
  include Measurable
  include Documentable
  include Imageable


  has_many :proposals
  belongs_to :proposal

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :check_dates, if: -> { starts_at && ends_at }
  validates_translation :title, presence: true, length: { in: 4..Campaing.title_max_length }

  scope :current, -> { where("starts_at <= :date AND :date <= ends_at", date: Time.current)}

  def documentables_note(documentable)
      doc_note = t "documents.form.note", max_documents_allowed: max_documents_allowed(documentable),
                             accepted_content_types: documentable_humanized_accepted_content_types(documentable.class),
                             max_file_size: max_file_size(documentable.class)
      doc_note.concat(t "customtext.campaigns.report_doc_desc")
  end

  private

    def check_dates
      if ends_at < starts_at
        errors.add(:starts_at, I18n.t("activerecord.errors.models.campaing.attributes.starts_at.range"))
      end
    end
end
