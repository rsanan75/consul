class CreateSitemessages < ActiveRecord::Migration[5.0]
  def change
    create_table :sitemessages do |t|
      t.string :name
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
