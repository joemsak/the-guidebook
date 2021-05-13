module AuthenticationHelpers
  def sign_in(scope)
    @signed_in_scope ||= if scope.is_a?(Symbol) || scope.is_a?(String)
                           create(scope)
                         else
                           scope
                         end

    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@signed_in_scope)
  end

  def sign_out
    @signed_in_scope = nil
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(nil)
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers
end
