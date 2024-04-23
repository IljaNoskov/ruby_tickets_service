class ValidateInputOutputService
  def self.validate(params)
    # инфо о билете json с status и body: id, event_id, type, status, user_id
    info_about_ticket = TicketInfoAdapter.new(ENV['PATH_TO_TICKET_INFO']).call(params[:ticket_id])
    /
    если статус 200 продолжаем дальше
    если статус 404 то делаем return с информацией, что билета с такой id не существует
    /
    info_about_ticket_hash = JSON.parse(info_about_ticket.body)
    # запишем в переменную id посетителя
    visitor_id = info_about_ticket_hash['user_id']
    # инфо о владельце билета json со status: true/false body: first_name, middle_name, last_name
    info_about_visitor = ValidateDocumentAdapter.new(ENV['PATH_TO_VISITOR_VALIDATE']).validate_document(visitor_id, params[:document])
    raise NotFound if info_about_visitor.status != 200 or info_about_ticket.status != 200
    /
    если статус 200, все хорошо,продолжаем
    если статус 404, возвращаем информацию, что такого посетителя вообще не существует в базе
    то есть владелец билета не совершал покупку
    /
    # инициалищируем переменную статус, изначально successfully, и по ходу проверок поменяем
    status = "successfully"
    
    # проверяем документы
    status = "failed" unless JSON.parse(info_about_visitor.body)['result']
    
    # совпадает ли тип турникета с типом билета
    status = "failed" if params[:type_tourniquet] != info_about_ticket_hash["type"]
    # совпадает ли мероприятие и билет на мероприятие
    
    status = "failed" if params[:event_id] != info_about_ticket_hash["event_id"]
    
    # проверить не заблокирован ли билет
    status = "failed" if info_about_ticket_hash["status"] == "block"
    # возвращаем хэш с результатом
    {
      'status' => status, 
      'first_name' =>JSON.parse(info_about_visitor.body)['visitor']['first_name'],
      'middle_name' =>JSON.parse(info_about_visitor.body)['visitor']['middle_name'],
      'last_name' =>JSON.parse(info_about_visitor.body)['visitor']['last_name']
    }
  end
end