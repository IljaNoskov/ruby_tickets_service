module VisitorsHelper
  def response_from(visitor)
    {
      'id' => visitor.id,
      'first_name' => visitor.first_name,
      'last_name' => visitor.last_name,
      'middle_name' => visitor.middle_name,
      'birthdate' => visitor.birthdate.to_formatted_s(:db)
    }
  end

  def to_request(visitor)
    {
      'first_name' => visitor.first_name,
      'last_name' => visitor.last_name,
      'middle_name' => visitor.middle_name,
      'birthdate' => visitor.birthdate.to_formatted_s(:db),
      'document_type' => visitor.document_type,
      'document_number' => visitor.document_number
    }
  end
end
