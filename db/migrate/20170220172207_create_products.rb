class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :SKU_ID
      t.integer :price
      t.string :description
      t.date :expire_date

      t.timestamps null: false
    end
  end
end
