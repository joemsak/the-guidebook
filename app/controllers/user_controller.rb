class UserController < ApplicationController
  skip_before_action :remember_browsing_scope

  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  private
  def root_path_helper
    user_dashboard_path
  end
end
