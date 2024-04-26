# frozen_string_literal: true

# Модель хранимой платежной транзакции
class Payment < ApplicationRecord
  enum status: %w[finished declined canceled processing].index_by(&:to_sym)
end
