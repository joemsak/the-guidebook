class CreateAuthentications < ActiveRecord::Migration[6.1]
  def change
    create_table :authentications, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :provider, null: false
      t.string :uid, null: false
      t.json :info, null: false, default: {}
      t.json :credentials, null: false, default: {}
      t.json :extra, null: false, default: {}

      t.timestamps
    end

    add_index :authentications, :provider
    add_index :authentications, [:user_id, :provider], unique: true
    add_index :authentications, [:user_id, :provider, :uid], unique: true
  end
end
