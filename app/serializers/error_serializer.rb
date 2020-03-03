class ErrorSerializer
  def initialize(error, status, param)
    @error = error
    @status = status
    @parameter = param
  end

  def errors
    {
      errors: [
        status: @status.to_s,
        source: { pointer: '/api/v1/sessions', parameter: @parameter },
        title: 'Invalid Credentials',
        detail: @error
      ]
    }
  end
end
