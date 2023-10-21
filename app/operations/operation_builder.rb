class OperationBuilder
  class << self
    def call(result, error_tracker)
      {
        success: error_tracker.success,
        errors: error_tracker.list_errors,
        result: result
      }
    end
  end
end