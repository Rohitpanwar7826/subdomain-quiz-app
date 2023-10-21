class ErrorTracker
  def initialize(errors=Array.new)
    @errors=errors
  end
  
  def any?
    @errors.blank?
  end

  def list_errors
    @errors.join(', ')
  end

  def success
    any?
  end

  def errors_count
    @errors.count
  end

  def add_error(error)
    @errors << error
  end

end