class Settings
  def self.fetch_booking_url
    ENV['FETCH_BOOKING_URL']
  end

  def self.create_visitor_url
    ENV['CREATE_VISITOR_URL']
  end

  def self.required_age
    ENV['REQUIRED_AGE'].to_i
  end
end
