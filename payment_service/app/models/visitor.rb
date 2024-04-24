class Visitor
  include ActiveModel::Model

  attr_accessor :id, :first_name, :last_name, :middle_name, :birthdate

  def persisted?
    false
  end
end
