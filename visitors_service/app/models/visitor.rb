class Visitor < ApplicationRecord
  enum document_type: %w[passport license certificate].index_by(&:to_sym)
  validates :first_name, :last_name, format: { with: /\A[а-яА-Я]+\z/, message: I18n.t(:only_letters) }
  validates :middle_name, format: {with: /\A[а-яА-Я]+\z/, message: I18n.t(:only_letters) }, if: Proc.new { |v| v.middle_name }

  validates_with DocumentNumberValidator

end
