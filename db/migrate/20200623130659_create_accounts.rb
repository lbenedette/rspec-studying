class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.boolean :vip
      t.integer :days_to_pay
      t.string :level # ["beginner", "medium", "expert"]
      t.string :country

      t.timestamps
    end
  end
end
