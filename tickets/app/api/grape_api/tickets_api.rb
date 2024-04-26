class GrapeApi
    class TicketsApi < Grape::API
    format :json

        # cписок запросов для билетов
        # рассчёт цены билета
        # бронирование билета
        # отмена брони или покупка
        # Информация о билете
        # блокирование/разблокирование билета

        namespace :tickets do
            get do
                present Ticket.all
            end
            
            # рассчёт цены билета
            namespace :price do
                params do
                    requires :event_id, type: Integer
                    requires :type, type: String
                end
                get do
                    response = CalculateTicketPriceService.calculate_price(params[:event_id], params[:type])
                    status response[:status]
                    present response[:body]
                end
            end

            # бронирование билета
            # отмена брони или покупка
            namespace :booking do
                params do
                    requires :action, type: String
                    optional :event_id, type: Integer
                    optional :type, type: String
                    optional :user_id, type: Integer
                    optional :ticket_id, type: Integer
                end

                put do
                    if params[:action] == 'create'
                        response = UpdateTicketService.create_booking(params[:event_id], params[:type])
                    elsif params[:action] == 'delete'
                        response = UpdateTicketService.delete_booking(params[:ticket_id])
                    else
                        response = UpdateTicketService.buy_ticket(params[:ticket_id], params[:user_id])
                    end
                    status response[:status]
                    present response[:body]
                end
            end

            # Информация о билете
            namespace :info do
                params do
                    requires :ticket_id, type: Integer
                end

                get do
                    response = GetTicketService.get_ticket(params[:ticket_id])
                    status response[:status]
                    present response[:body]
                end
            end

            # блокирование/разблокирование билета
            namespace :block do
                params do
                    requires :ticket_id, type: Integer
                    requires :block, type: Boolean
                end

                put do
                    response = UpdateTicketService.block_ticket(params[:ticket_id], params[:block])
                    status response[:status]
                    present response[:body]
                end
            end
        end
    end
end