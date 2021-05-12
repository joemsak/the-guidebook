class User::SessionsController < UserController
  def destroy
    sign_out(current_user)
    redirect_to root_path, notice: t('.success')
  end
end
