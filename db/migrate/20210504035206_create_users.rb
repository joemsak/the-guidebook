class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :auth_token, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :slug, unique: true
    add_index :users, :auth_token, unique: true
  end
end
