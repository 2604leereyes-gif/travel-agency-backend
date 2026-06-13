class CreateTravelPackages < ActiveRecord::Migration[7.2]
  def change
    create_table :travel_packages do |t|
      t.string :title, null: false

      t.text :description

      t.decimal :base_price, precision: 10, scale: 2, null: false

      t.boolean :show_price, default: true

      t.integer :number_of_travelers

      t.string :destination, null: false

      t.boolean :is_active, default: true

      t.timestamps
    end

    add_index :travel_packages, :destination
    add_index :travel_packages, :is_active
  end
end
