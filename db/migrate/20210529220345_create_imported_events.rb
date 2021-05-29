class CreateImportedEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :imported_events, id: :uuid do |t|
      t.references :coaching_session, foreign_key: true, type: :uuid, comment: "A coaching session might not be created for the imported event"
      t.references :client_profile, null: false, foreign_key: true, type: :uuid
      t.references :coach_profile, null: false, foreign_key: true, type: :uuid

      t.string :external_id, null: false
      t.string :external_url, null: false
      t.string :name, null: false
      t.string :external_status, null: false

      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.datetime :external_created_at, null: false
      t.datetime :external_updated_at, null: false

      t.jsonb :event_type, null: false
      t.jsonb :location, null: false

      t.integer :invitees_counter_total, null: false
      t.integer :invitees_counter_active, null: false
      t.integer :invitees_counter_limit, null: false

      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
