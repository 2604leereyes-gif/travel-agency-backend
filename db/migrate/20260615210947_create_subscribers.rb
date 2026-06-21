class CreateSubscribers < ActiveRecord::Migration[7.2]
  def change
    create_table :subscribers do |t|
      t.string :email, null: false
      t.string :name
      t.integer :status, null: false, default: 0
      t.string :unsubscribe_token
      t.datetime :subscribed_at

      t.index :email, unique: true
      t.index :unsubscribe_token, unique: true

      t.timestamps
    end
  end
end
