class CalendlyAuthentication < Authentication
  def api_client
    @client ||= GuidebookCalendlyClient.new(token, refresh_token, token_expires_at)
  end

  def coach
    user.coach_profile
  end

  def calendly_user
    @calendly_user ||= api_client.me
  end

  def scheduled_events
    @events ||= calendly_user.scheduled_events
  end

  def sync_remote_data!
    return false unless credentials.present?
    check_token!

    scheduled_events.each do |event|
      next unless event.invitees_counter_limit == 1 # assume 1 on 1

      invitee = event.invitees.first

      client = User.client.find_by(email: invitee.email)

      unless client
        client = coach.pending_clients.find_or_initialize_by(email: invitee.email)
        client.build_client_profile unless client.client_profile
        client.update(name: invitee.name)
      end

      is_imported = ImportedEvent.exists?(external_id: event.uuid)
      is_converted = user.coach_profile.coaching_sessions.exists?(external_id: event.uuid)

      next if is_imported || is_converted

      user.coach_profile.imported_events.create!({
        client_profile: client.client_profile,
        external_id: event.uuid,
        external_url: event.uri,
        name: event.name,
        external_status: event.status,
        start_time: event.start_time,
        end_time: event.end_time,
        external_created_at: event.created_at,
        external_updated_at: event.updated_at,
        event_type: {
          external_id: event.event_type.uuid,
          external_uri: event.event_type.uri,
          active: event.event_type.active,
          color: event.event_type.color,
          description_html: event.event_type.description_html,
          description_plain: event.event_type.description_plain,
          duration: event.event_type.duration,
          internal_note: event.event_type.internal_note,
          kind: event.event_type.kind,
          name: event.event_type.name,
          pooling_type: event.event_type.pooling_type,
          external_scheduling_url: event.event_type.scheduling_url,
          external_slug: event.event_type.slug,
          type: event.event_type.type,
          external_created_at: event.event_type.created_at,
          external_updated_at: event.event_type.updated_at,
          external_owner_id: event.event_type.owner_uuid,
          external_owner_uri: event.event_type.owner_uri,
          owner_name: event.event_type.owner_name,
          owner_type: event.event_type.owner_type
        },
        location: {
          type: event.location.type,
          location: event.location.location,
          external_status: event.location.status,
          external_join_url: event.location.join_url,
          external_data: event.location.data
        },
        invitees_counter_total: event.invitees_counter_total,
        invitees_counter_active: event.invitees_counter_active,
        invitees_counter_limit: event.invitees_counter_limit
      })
    end
  end

  private

  def check_token!
    if api_client.access_token.expired?
      api_client.refresh!
    end
  end

  def token
    credentials["token"]
  end

  def refresh_token
    credentials["refresh_token"]
  end

  def token_expires_at
    credentials["expires_at"]
  end
end
