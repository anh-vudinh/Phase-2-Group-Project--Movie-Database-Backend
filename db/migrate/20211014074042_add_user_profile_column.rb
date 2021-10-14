class AddUserProfileColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :userprofile, :string
  end
end
