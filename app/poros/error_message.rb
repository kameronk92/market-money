class ErrorMessage
  attr_reader :message, :status_code

  def initialize(message, status_code = 404)
    @message = message
    @status_code = status_code
  end

  def detail
    if @status_code == 400
      "Validation failed: " + @message.join(", ")
    elsif @status_code == 404
      @message
    else
      "He's dead, Jim. Error Code #{@status_code}"
    end
  end
end