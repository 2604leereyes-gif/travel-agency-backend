class AddImageToTravelPackages < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_packages, :image, :string
  end
end
