class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :description
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
