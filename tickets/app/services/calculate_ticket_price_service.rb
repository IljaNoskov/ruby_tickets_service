class CalculateTicketPriceService
    def self.calculate_price(event_id, ticket_type)
        event = Event.find(event_id)
        if even
            if ticket_type = 'ordinary'
                base_price = event.ordinary_ticket_price
                base_count = event.ordinary_ticket_count
                current_count = event.tickets.where(ticket_type: ticket_type, status: 'free').count
            elsif ticket_type = 'vip'
                base_price = event.vip_ticket_price
                base_count = event.vip_ticket_count
                current_count = event.tickets.where(ticket_type: ticket_type, status: 'free').count
            else
                return nil
            end

            if current_count != base_count
                part_of_buyed = (current_count / base_count).round(1, half: :down)
                current_ticket_price = base_price * (1 + part_of_buyed)
                {status: 200, body: current_ticket_price}
            else 
                {status: 200, body: "sold out"}
            end
        else
            {status: 404, body: "event not found"}
        end
    end
end