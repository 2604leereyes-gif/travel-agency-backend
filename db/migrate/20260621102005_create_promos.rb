class CreatePromos < ActiveRecord::Migration[7.2]
  def change
    create_table :promos do |t|
      t.string  :title, null: false
      t.string  :details, null: false
      t.boolean :active, null:false
      t.date    :deleted_at

      t.timestamps
    end
  end
end
