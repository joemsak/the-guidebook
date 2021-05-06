class Coach::RegistrationsController < ApplicationController
  def new
    @coach = Coach.new
  end

  def create
    @coach = Coach.new(coach_params)

    if @coach.save
      sign_in(@coach)
      redirect_to @coach, notice: t('.success')
    else
      render :new
    end
  end

  private
  def coach_params
    params.require(:coach)
      .permit(:name, :email, :password, :password_confirmation)
  end
end
