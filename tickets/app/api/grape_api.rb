class GrapeApi < Grape::API
    mount EventsApi
    mount TicketsApi
end