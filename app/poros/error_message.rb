class ErrorMessage
  attr_reader :id, :message, :status_code

  def initialize(message, status_code)
    @message = message
    @status_code = status_code
  end
end