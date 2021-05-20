class PublicController < ApplicationController
  skip_before_action :remember_browsing_scope

  before_action :require_no_authentication
end
