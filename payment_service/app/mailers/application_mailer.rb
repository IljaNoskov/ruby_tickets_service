# frozen_string_literal: true

# Базовый класс для определяемых мейлеров
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
