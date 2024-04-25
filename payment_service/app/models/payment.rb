# frozen_string_literal: true

class Payment < ApplicationRecord
  enum status: %w[finished declined canceled processing].index_by(&:to_sym)
end
