class CreateCampaings < ActiveRecord::Migration[5.0]
  def change
    create_table :campaings do |t|
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps null: false
    end

    reversible do |dir|
      dir.up do
        Campaing.create_translation_table! :title => :string, :description => :text
      end

      dir.down do
        Campaing.drop_translation_table!
      end
    end
  end
end
