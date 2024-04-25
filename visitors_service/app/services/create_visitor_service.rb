# frozen_string_literal: true

class CreateVisitorService
  def self.call(params)
    new_visitor = Visitor.new(params) and new_visitor.pretify
    existing_visitor = Visitor.find_by(document_type: new_visitor.document_type,
                                       document_number: new_visitor.document_number)
    visitor = existing_visitor || new_visitor

    visitor.save! unless visitor.persisted?

    visitor
  end
end
