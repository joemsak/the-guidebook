class CreateClientInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :client_invitations, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :slug, null: false

      t.integer :status, null: false, default: 0
      t.json :failure, default: {}

      t.uuid :sender_id, null: false, foreign_key: true
      t.string :sender_type, null: false

      t.uuid :recipient_id,
        comment: "Recipient is attached when a client profile is created upon acceptance"

      t.string :recipient_type,
        comment: "Recipient is attached when a client profile is created upon acceptance"

      t.timestamps
    end

    add_index :client_invitations, :email
    add_index :client_invitations, :slug
    add_index :client_invitations, :status
    add_index :client_invitations, [:sender_id, :sender_type]
    add_index :client_invitations, [:recipient_id, :recipient_type]
    add_index :client_invitations, [:sender_id, :sender_type, :email]
  end
end
