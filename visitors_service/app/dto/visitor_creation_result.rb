class VisitorCreationResult
  attr_reader :visitor, :errors

  def initialize(visitor)
    @successful = visitor.persisted?
    @visitor = visitor
    @errors = visitor.errors
  end

  def successful?
    @successful
  end
end
