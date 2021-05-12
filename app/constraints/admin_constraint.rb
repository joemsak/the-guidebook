class AdminConstraint
  def initialize(&block)
    @block = block || ->(_) { true }
  end

  def matches?(req)
    user = current_user(req)
    user.present? && user.admin_profile.present? && @block.call(user)
  end

  def current_user(req)
    User.find_by(auth_token: auth_token(req))
  end

  def auth_token(req)
    req.cookie_jar.signed[ApplicationController::AUTH_TOKEN_KEY]
  end
end
