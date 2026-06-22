class CreateContacts < ActiveRecord::Migration[7.2]
  def change
    create_table :contacts do |t|
      t.json :phone_numbers, null: false
      t.json :emails, null: false
      t.json :business_hours
      t.text :google_maps_url, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
