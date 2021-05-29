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
      redirect_to [:coach, @coaching_session], notice: t(".success")
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
      redirect_to [:coach, @coaching_session], notice: t(".success")
    else
      render :edit
    end
  end

  def destroy
    @coaching_session = current_coach.coaching_sessions.find(params[:id])
    @coaching_session.destroy
    redirect_to [:coach, :coaching_sessions],
      notice: t(".success", name: @coaching_session.client_name)
  end

  private

  def coaching_session_params
    params.require(:coaching_session)
      .permit(:client_profile_id, :start_time, :video_embed, :notes)
  end
end
