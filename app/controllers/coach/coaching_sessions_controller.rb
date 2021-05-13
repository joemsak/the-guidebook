class Coach::CoachingSessionsController < CoachController
  def index
    @coaching_sessions = current_coach.coaching_sessions
  end

  def new
    @coaching_session = current_coach.coaching_sessions.build
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

    @coaching_session.duration_complex = view_context.pluralize(
      @coaching_session.duration,
      @coaching_session.duration_unit.singularize
    )
  end

  def update
    @coaching_session = current_coach.coaching_sessions.find(params[:id])

    if @coaching_session.update(coaching_session_params)
      redirect_to [:coach, @coaching_session], notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @coaching_session = current_coach.coaching_sessions.find(params[:id])
    @coaching_session.destroy
    redirect_to [:coach, :coaching_sessions],
      notice: t('.success', name: @coaching_session.client_name)
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
