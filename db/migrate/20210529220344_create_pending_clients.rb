class CreatePendingClients < ActiveRecord::Migration[6.1]
  def change
    create_table :pending_clients, id: :uuid do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.integer :status, null: false, default: 0
      t.references :client_invitation, foreign_key: true, type: :uuid, comment: "Invitations not required"
      t.references :coach_profile, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
