class PublicController < ApplicationController
  before_action :require_no_authentication
end
