class CreateVars < ActiveRecord::Migration
  def change
    create_table :vars do |t|
      t.integer :product_id
      t.string :color

      t.timestamps null: false
    end
  end
end
