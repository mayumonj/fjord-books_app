class AddProfilrToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :postal_code, :integer
    add_column :users, :address, :string
    add_column :users, :seif_introduction, :string
  end
end
