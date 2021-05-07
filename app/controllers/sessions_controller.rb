class SessionsController < ApplicationController
  def create
    if resource = authenticate_resource
      sign_in(resource)
      redirect_to [resource, :dashboard], notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to root_path, notice: t('.success')
  end

  private
  def authenticate_resource
    if resource = User.find_by(email: session_params[:email])
      resource.authenticate(session_params[:password])
    end
  end

  def session_params
    params.permit(:email, :password, :remember_me)
  end
end
