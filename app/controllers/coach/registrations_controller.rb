class Coach::RegistrationsController < ApplicationController
  def new
    @coach = User.new
  end

  def create
    @coach = User.new(coach_params)

    if @coach.save
      @coach.create_coach_profile!
      sign_in(@coach)
      redirect_to coach_dashboard_path, notice: t('.success')
    else
      render :new
    end
  end

  private
  def coach_params
    params.require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end
end
