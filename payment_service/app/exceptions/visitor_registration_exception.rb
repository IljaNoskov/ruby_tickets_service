class VisitorRegistrationException < Exception
  attr_reader :response

  def initialize(response)
    @response = response
  end
end
