class Coach::CoachingSessionsController < CoachController
  DEFAULT_DURATION = 1

  def index
    @coaching_sessions = current_coach.coaching_sessions
  end

  def new
    @coaching_session = current_coach.coaching_sessions
      .build(duration: DEFAULT_DURATION)
  end

  def create
    @coaching_session = current_coach.coaching_sessions
      .build(coaching_session_params)

    if @coaching_session.save
      redirect_to [:coach, @coaching_session], notice: t('.success')
    else
      render :new
    end
  end

  def show
    @coaching_session = current_coach.coaching_sessions.find(params[:id])
  end

  def edit
    @coaching_session = current_coach.coaching_sessions.find(params[:id])
  end

  def update
    @coaching_session = current_coach.coaching_sessions.find(params[:id])

    if @coaching_session.update(coaching_session_params)
      redirect_to [:coach, @coaching_session], notice: t('.success')
    else
      render :edit
    end
  end

  private
  def coaching_session_params
    params.require(:coaching_session)
      .permit(:client_profile_id, :starts_at)
      .merge(
        duration: duration,
        duration_unit: duration_unit
      )
  end

  def duration
    duration_complex.scan(/\d+/)[0].to_i
  end

  def duration_unit
    duration_complex.scan(/[a-z]+/)[0].pluralize
  end

  def duration_complex
    params[:coaching_session][:duration_complex]
  end
end
