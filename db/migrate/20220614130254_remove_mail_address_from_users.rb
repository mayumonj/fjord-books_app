class RemoveMailAddressFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :mail_address, :string
  end
end
