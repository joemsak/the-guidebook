class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  private
  def root_path_helper
    user_dashboard_path
  end
end
