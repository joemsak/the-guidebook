class Public::SessionsController < PublicController
  def create
    if resource = authenticate_resource
      sign_in(resource)
      redirect_to [resource, :dashboard], notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
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
