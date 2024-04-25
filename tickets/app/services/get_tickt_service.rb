class GetTicketService
    def self.get_ticket(ticket_id)
        ticket = Ticket.find(ticket_id)
        unless ticket
            result = {status: 404, body: "no ticket with id = #{ticket_id}"}
        else
            result = {status: 200, body: {
                id: ticket.id,
                event_id: ticket.event_id,
                type: ticket.ticket_type, 
                status: ticket_type.status,
                user_id: ticket.user_id
                }
            }
        end
        result
    end
end