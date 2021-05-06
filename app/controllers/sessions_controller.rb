class SessionsController < ApplicationController
  def create
    if coach = authenticate_coach
      sign_in(coach)
      redirect_to coach, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
  end

  def destroy
    sign_out(current_coach)
    redirect_to root_path, notice: t('.success')
  end

  private
  def authenticate_coach
    if coach = Coach.find_by(email: session_params[:email])
      coach.authenticate(session_params[:password])
    end
  end

  def session_params
    params.permit(:email, :password, :remember_me)
  end
end
