class AddPendingClientToClientProfiles < ActiveRecord::Migration[6.1]
  def up
    add_reference :client_profiles, :pending_client, foreign_key: true, type: :uuid,
                                                     comment: "PendingClient is only required if the user is blank, vice-versa"

    change_column_null :client_profiles, :user_id, null: true,
                                                   comment: "User is only required if the pending_client is blank, vice-versa"
  end

  def down
    remove_reference :client_profiles, :pending_client
  end
end
