class AddReportdescriptionToCampaings < ActiveRecord::Migration[5.0]
  def self.up
    change_table(:campaing_translations) do |t|
      t.text :report_description
    end
  end
  def self.down
    remove_column :campaing_translations, :report_description
  end
end
