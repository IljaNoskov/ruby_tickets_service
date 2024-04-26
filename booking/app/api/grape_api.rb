class GrapeApi < Grape::API
  mount BookingsApi
  mount CreateBookingsApi
  mount DeleteBookingsApi
  mount PutBookingsApi
end