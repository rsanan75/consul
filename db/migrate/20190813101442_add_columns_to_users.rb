class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :identify_yourself, :string
    add_column :users, :education, :string
    add_column :users, :residence, :string
    add_column :users, :native_language, :string
    add_column :users, :name, :string
    add_column :users, :surname, :string
  end
end
