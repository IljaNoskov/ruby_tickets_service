json.extract! event, :id, :name, :date, :ordinary_ticket_count, :vip_ticket_count, :ordinary_ticket_price, :vip_ticket_count, :created_at, :updated_at
json.url event_url(event, format: :json)
