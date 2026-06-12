class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string  :username,           null: false, default: ''
      t.string  :email,              null: false, default: ''
      t.string  :encrypted_password, null: false, default: ''

      t.timestamps
    end
  end
end
