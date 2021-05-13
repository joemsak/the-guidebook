class CreateCoachingSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :coaching_sessions, id: :uuid do |t|
      t.references :client_profile, null: false, foreign_key: true, type: :uuid
      t.references :coach_profile, null: false, foreign_key: true, type: :uuid
      t.timestamp :starts_at, null: false
      t.integer :duration, null: false, default: 1
      t.integer :duration_unit, null: false, default: 0

      t.timestamps
    end

    add_index :coaching_sessions, :starts_at

    add_index :coaching_sessions,
      [:coach_profile_id, :client_profile_id],
      name: :coaching_sessions_coach_client
  end
end
