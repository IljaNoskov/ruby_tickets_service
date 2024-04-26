class FindEventsService
    def self.find(first_date, second_date, event_name=nil)
        orders = event_name ? Event.where(name: event_name) : Event.all
        orders.where('date >= :first_date and date <= :second_date', first_date: first_date, second_date: second_date)
    end
end