class GrapeApi
    class EventsApi < Grape::API
    format :json

        # cписок запросов для мероприятий
        # создание мероприятия
        # получение списка мероприятий

        namespace :events do
            get do
                present Event.all
            end

            namespace :create do
                params do
                    requires :name, type: String
                    requires :date, type: Date
                    requires :ordinary_ticket_count, type: Integer
                    requires :vip_ticket_count, type: Integer
                    requires :ordinary_ticket_price, type: Float
                    requires :vip_ticket_price, type: Float
                end
                post do
                    created_event =  CreateEventService.create(params)
                end
            end
        end
    end
end
   