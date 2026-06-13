class AddTripDetailsToTravelPackages < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_packages, :number_of_days, :integer, null: false, default: 1
    add_column :travel_packages, :number_of_nights, :integer, null: false, default: 0

    add_column :travel_packages, :deleted_at, :datetime

    add_index :travel_packages, :deleted_at
  end
end
