json.extract! ticket, :id, :user_id, :ticket_type, :status, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
