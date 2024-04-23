class VisitorValidationResult
  attr_reader :result, :visitor

  def initialize(result, visitor)
    @result = result
    @visitor = visitor
  end

end
