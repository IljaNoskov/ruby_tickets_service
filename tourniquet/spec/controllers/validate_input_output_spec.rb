require 'rails_helper'

RSpec.describe ValidateInputOutputService, :type => :request do
  it 'return body status successfully' do
    # параметр запроса билетам
    parametr = {
        'ticket_id' => 1
      }
    #   ответ билетов
    res_for_ticket = {
      'id' => 1,
      'event_id' => 1,
      'type' => 'standart',
      'status' => 'buy',
      'user_id' => 3
    }
    # параметр к запросам посетителей
    parametr2 = {
        'visitor_id' => 3,
        'document' => '123'
      }
    #   ответ сервиса посетителей
    res_fot_visitor={
        'result' => true,
        'visitor' => {
            'first_name' => 'D',
            'middle_name' => 'I',
            'last_name' => 'SH'
        }
    }
    # параметр посетителя при входе
    params = {
        :ticket_id=>1,
        :document => '123',
        :type_tourniquet => "standart",
        :event_id => 1
    }
    # результат
    result = {
        'status' => 'successfully', 
        'first_name' =>'D',
        'middle_name' =>'I',
        'last_name' =>'SH'
    }
    stub_request(:get, ENV['PATH_TO_TICKET_INFO']).with(query: parametr)
    .to_return(status: 200, body: res_for_ticket.to_json, headers: {})

    stub_request(:get, ENV['PATH_TO_VISITOR_VALIDATE']).with(query: parametr2)
    .to_return(status: 200, body: res_fot_visitor.to_json, headers: {})

    # Получаем ответ метода
    response = ValidateInputOutputService.validate(params)
    # сравниваем, что получили и что ожидали
    expect(response).to eq(result)
  end
end