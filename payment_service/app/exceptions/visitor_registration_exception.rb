# frozen_string_literal: true

class VisitorRegistrationException < RuntimeError
  attr_reader :response

  def initialize(response)
    @response = response
  end
end
