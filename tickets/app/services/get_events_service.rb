class GetEventsService
    def self.find_all(event_name=nil)
        events = event_name ? Event.where(name: event_name) : Event.all
        events.length.times do |i|
            events[i] = {
                name: events[i].name,
                date: events[i].date,
                ordinary_ticket_count: events[i].ordinary_ticket_count,
                vip_ticket_count: events[i].vip_ticket_count,
                ordinary_ticket_price: events[i].ordinary_ticket_price,
                vip_ticket_price: events[i].vip_ticket_price
            }
        end
        {status: 200, body: events}
    end

    def find_by_id(event)
        event = {
            name: event.name,
            date: event.date,
            ordinary_ticket_count: event.ordinary_ticket_count,
            vip_ticket_count: event.vip_ticket_count,
            ordinary_ticket_price: event.ordinary_ticket_price,
            vip_ticket_price: event.vip_ticket_price
        }
    end
end