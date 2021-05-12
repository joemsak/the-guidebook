class UserController < ApplicationController
  before_action :authenticate_user!

  private
  def root_path_helper
    user_dashboard_path
  end
end
