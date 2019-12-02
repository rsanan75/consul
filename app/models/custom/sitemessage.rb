require 'csv'

class Sitemessage < ApplicationRecord

  validates :name, :email, :message, presence: true
  
  def self.to_csv(options = {})
    desired_columns = ["id", "name", "email", "created_at", "message"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |sitemessage|
        csv << sitemessage.attributes.values_at(*desired_columns)
      end
    end
  end
end
