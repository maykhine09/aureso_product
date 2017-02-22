class AddPriceDefaultToProductTbl1 < ActiveRecord::Migration
  def self.up
    change_column :products, :price, :integer, :default => 0
  end

  def self.down
    change_column :products, :price, :integer, :default => nil
  end
end
