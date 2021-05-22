class ReformCoachingSessionsSchema < ActiveRecord::Migration[6.1]
  def change
    remove_column :coaching_sessions, :starts_at, :datetime, null: false
    remove_column :coaching_sessions, :duration, :integer, null: false, default: 1
    remove_column :coaching_sessions, :duration_unit, :integer, null: false, default: 0

    add_column :coaching_sessions, :external_id, :string, null: false
    add_column :coaching_sessions, :external_url, :string, null: false
    add_column :coaching_sessions, :name, :string, null: false
    add_column :coaching_sessions, :external_status, :string, null: false
    add_column :coaching_sessions, :start_time, :datetime, null: false
    add_column :coaching_sessions, :end_time, :datetime, null: false
    add_column :coaching_sessions, :external_created_at, :datetime, null: false
    add_column :coaching_sessions, :external_updated_at, :datetime, null: false

    add_column :coaching_sessions, :event_type, :jsonb, null: false
    add_column :coaching_sessions, :location, :jsonb, null: false

    add_column :coaching_sessions, :invitees_counter_total, :integer, null: false
    add_column :coaching_sessions, :invitees_counter_active, :integer, null: false
    add_column :coaching_sessions, :invitees_counter_limit, :integer, null: false
  end
end
