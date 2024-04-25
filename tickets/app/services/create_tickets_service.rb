class CreateTicketsService

    # Основные поля для tickets
    # t.integer "user_id"
    # t.string "ticket_type"
    # t.string "status"
    def self.create(event)
        # не прописываю поле user_id, так как билет ещё не куплен
        event.ordinary_ticket_count.times do
            event.tickets.create(ticket_type: 'ordinary', status: 'free')
        end
        event.vip_ticket_count.times do
            event.tickets.create(ticket_type: 'vip', status: 'free')
        end
    end
end