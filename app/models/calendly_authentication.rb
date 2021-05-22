class CalendlyAuthentication < Authentication
  def client
    @client ||= GuidebookCalendlyClient.new(token, refresh_token, token_expires_at)
  end

  def calendly_user
    @calendly_user ||= client.me
  end

  def scheduled_events
    @events ||= calendly_user.scheduled_events
  end

  def sync_remote_data!
    return false unless credentials.present?
    check_token!

    scheduled_events.each do |event|
      invitee_email = event.invitees.first.email # assume 1 on 1
      client = User.client.find_by(email: invitee_email)

      next if !client || user.coach_profile.coaching_sessions.exists?(external_id: event.uuid)

      user.coach_profile.coaching_sessions.create!({
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
          owner_type: event.event_type.owner_type,
        },
        location: {
          type: event.location.type,
          location: event.location.location,
          external_status: event.location.status,
          external_join_url: event.location.join_url,
          external_data: event.location.data,
        },
        invitees_counter_total: event.invitees_counter_total,
        invitees_counter_active: event.invitees_counter_active,
        invitees_counter_limit: event.invitees_counter_limit,
      })
    end
  end

  private
  def check_token!
    if client.access_token.expired?
      client.refresh!
    end
  end

  def token
    credentials['token']
  end

  def refresh_token
    credentials['refresh_token']
  end

  def token_expires_at
    credentials['expires_at']
  end
end
