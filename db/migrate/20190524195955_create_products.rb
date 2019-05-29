class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.date :expire_date
      t.text :images
      t.string :sku_id, null: false
      t.decimal :price
      t.text :description
      t.boolean :admin_approved, default: true
      t.timestamps null: false
      t.index [:sku_id], unique: true
    end
  end
end
