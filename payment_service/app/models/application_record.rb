# frozen_string_literal: true

# Базовый класс для определяемых ActiveRecord моделей
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
