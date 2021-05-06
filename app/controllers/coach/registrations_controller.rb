class Coach::RegistrationsController < ApplicationController
  def new
    @coach = Coach.new
  end
end
