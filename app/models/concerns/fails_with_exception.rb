module FailsWithException
  extend ActiveSupport::Concern

  included do
    cattr_accessor :previous_change_method, :resolution_status
    after_commit :clear_failure, if: :resolved_failure?
  end

  class_methods do
    def fails_with_exception(field, resolved_when:)
      self.previous_change_method = "#{field}_previous_change"
      self.resolution_status = resolved_when
    end
  end

  def failed_with_exception!(exception)
    update(
      status: :failed,
      failure: { message: exception.message, backtrace: exception.backtrace }
    )
  end

  def failure_message
    failure[:message] || ""
  end

  def failure_trace(scope: :full, limit: nil)
    backtrace = failure[:backtrace] || []
    limit ||= backtrace.length

    if scope == :full
      backtrace.take(limit)
    elsif scope == :app
      app_only_backtrace(backtrace, limit)
    else
      backtrace
    end
  end

  def failure
    super.with_indifferent_access
  end

  private
  def app_only_backtrace(backtrace, limit)
    result = backtrace.select { |l| l.starts_with?("/app/") }.take(limit)

    if limit == 1
      result[0]
    else
      result
    end
  end

  def clear_failure
    update(failure: {})
  end

  def resolved_failure?
    _previous_change == [:failed, resolution_status]
  end

  def _previous_change
    prev_change = send(self.class.previous_change_method) || []
    prev_change.compact.map(&:to_sym)
  end

  def resolution_status
    self.class.resolution_status
  end
end
