# frozen_string_literal: true

class GrapeApi
  module Entities
    class Payment < Grape::Entity
      expose :id
      expose :booking_number
      expose :event_id
      expose :visitor_id
      expose :price
      expose :status
    end
  end
end
