class AddAgeIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :age_id, :integer
    add_column :users, :avatar, :string
    add_column :users, :introduction, :text
  end
end
