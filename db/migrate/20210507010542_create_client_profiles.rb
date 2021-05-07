class CreateClientProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :client_profiles, id: :uuid do |t|
      t.references :user, index: {:unique=>true}, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
