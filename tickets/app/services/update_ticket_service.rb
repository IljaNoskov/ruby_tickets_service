class UpdateTicketService
    def self.create_booking(event_id, ticket_type)
        ticket = Event.find(event_id).tickets.where(
            'ticket_type = :ticket_type and status = :ticket_status', ticket_type: ticket_type, ticket_status: 'free'
        ).first
        if ticket
            ticket.status = 'booking'
            ticket.save
            result = {status: 201, body: {
                id: ticket.id,
                event_id: event_id,
                type: ticket.ticket_type, 
                price: CalculateTicketPriceService.calculate_price(event_id, ticket_type),
                status: ticket.status }
            }
        else
            result = {status: 200, body: "sold_out"}
        end
        result
    end

    def self.delete_booking(ticket_id)
        ticket = Ticket.find_by(id: ticket_id)
        if ticket.nil?
            result = {status: 404, body: "no ticket with id = #{ticket_id}"}
        elsif ticket.status == 'booking'
            ticket.status = 'free'
            ticket.save
            result = {status: 201, body: 'booking deleted'}
        else
            result = {status: 400, body: "ticket #{ticket_id} whas not booking"}
        end
        result
    end

    def self.buy_ticket(ticket_id, user_id)
        ticket = Ticket.find_by(id: ticket_id)
        if ticket.nil?
            result = {status: 404, body: "no ticket with id = #{ticket_id}"}

        elsif ticket.status == 'booking'
            ticket.status = 'buy'
            ticket.user_id = user_id
            ticket.save
            result = {status: 201, body: {
                id: ticket.id,
                event_id: ticket.event_id,
                type: ticket.ticket_type,
                status: ticket.status }
            }
        else
            result = {status: 400, body: "ticket #{ticket_id} whas not booking"}
        end
        result
    end

    def self.block_ticket(ticket_id, block)
        ticket = Ticket.find_by(id: ticket_id)
        if ticket.nil?
            result = {status: 404, body: "no ticket with id = #{ticket_id}"}
        elsif block and ticket.status == 'buy'
            ticket.status = 'block'
            ticket.save
            result = {status: 201, body: {
                id: ticket.id,
                event_id: ticket.event_id,
                type: ticket.ticket_type,
                status: ticket.status }
            }
        elsif !block and ticket.status == 'block'
            ticket.status = 'buy'
            ticket.save
            result = {status: 201, body: {
                id: ticket.id,
                event_id: ticket.event_id,
                type: ticket.ticket_type,
                status: ticket.status }
            }
        elsif block
            result = {status: 404, body: "no one buy ticket #{ticket_id}"}
        elsif ticket.status != 'block'
            result = {status: 404, body: "ticket #{ticket_id} is not blocked"}
        end
        result
    end
end