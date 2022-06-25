class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :postal_code
      t.string :address
      t.string :self_introduction

      t.timestamps
    end
  end
end
