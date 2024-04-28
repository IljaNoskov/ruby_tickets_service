class CreateEventService

    # t.string "name"
    # t.date "date"
    # t.integer "ordinary_ticket_count"
    # t.integer "vip_ticket_count"
    # t.float "ordinary_ticket_price"
    # t.float "vip_ticket_price"

    def self.create(event_params)
        event = Event.create(
            name: event_params['name'],
            date: event_params['date'],
            ordinary_ticket_count: event_params['ordinary_ticket_count'].to_i,
            vip_ticket_count: event_params['vip_ticket_count'].to_i,
            ordinary_ticket_price: event_params['ordinary_ticket_price'].to_f,
            vip_ticket_price: event_params['vip_ticket_price'].to_f
        )
        CreateTicketsService.create(event)
        event
    end
end