class CreateInquiries < ActiveRecord::Migration[7.2]
  def change
    create_table :inquiries do |t|
      t.string  :email, null: false
      t.string  :full_name, null: false
      t.string  :phone_number

      t.string  :destination

      t.date    :departure_date
      t.date    :return_date

      t.integer :number_of_travelers
      t.decimal :estimated_budget, precision: 12, scale: 2

      t.text    :notes

      t.references :travel_package, null: true, foreign_key: true

      t.integer :status, default: 0, null: false

      t.datetime :deleted_at

      t.timestamps
    end

    add_index :inquiries, :email
    add_index :inquiries, :status
    add_index :inquiries, :departure_date
    add_index :inquiries, :deleted_at
  end
end