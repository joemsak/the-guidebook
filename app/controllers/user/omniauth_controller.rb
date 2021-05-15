class User::OmniauthController < ApplicationController
  def create
    binding.pry
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
