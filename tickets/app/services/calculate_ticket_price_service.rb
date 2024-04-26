class CalculateTicketPriceService
    def self.calculate_price(event_id, ticket_type)
        event = Event.find_by(id: event_id)
        if event
            if ticket_type == 'ordinary'
                base_price = event.ordinary_ticket_price
                base_count = event.ordinary_ticket_count
                current_count = event.tickets.where(ticket_type: ticket_type, status: 'free').count
            elsif ticket_type == 'vip'
                base_price = event.vip_ticket_price
                base_count = event.vip_ticket_count
                current_count = event.tickets.where(ticket_type: ticket_type, status: 'free').count
            else
                result = {status: 404, body: "we have not tickets with type #{ticket_type}"}
            end

            if current_count != 0 and base_count != 0
                part_of_buyed = ((base_count - current_count) / base_count.to_f).round(1, half: :down)
                current_ticket_price = base_price * (1 + part_of_buyed)
                result =  {status: 200, body: current_ticket_price.to_i}
            else 
                result = {status: 200, body: "sold out"}
            end
        else
            result = {status: 404, body: "event not found"}
        end

        result
    end
end