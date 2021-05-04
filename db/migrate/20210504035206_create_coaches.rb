class CreateCoaches < ActiveRecord::Migration[6.1]
  def change
    create_table :coaches, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password

      t.timestamps
    end
    add_index :coaches, :email, unique: true
  end
end
