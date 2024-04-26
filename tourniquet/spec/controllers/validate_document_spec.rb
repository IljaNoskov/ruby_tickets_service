require 'rails_helper'

RSpec.describe ValidateDocumentAdapter, :type => :request do
  it 'return body' do
    parametr = {
        'visitor_id' => 1,
        'document' => '123'
      }
    res={
        'result' => true,
        'visitor' => {
            'first_name' => 'D',
            'middle_name' => 'I',
            'last_name' => 'SH'
        }
    }
    # подставляем данные, которые должен возвращать сторонний сервис

    stub_request(:get, ENV['PATH_TO_VISITOR_VALIDATE']).with(query: parametr)
    .to_return(status: 200, body: res.to_json, headers: {})
    # Получаем ответ метода
    response = ValidateDocumentAdapter.new(ENV['PATH_TO_VISITOR_VALIDATE']).validate_document(1,'123')
    # сравниваем, что получили и что ожидали
    expect(response.body).to eq(res.to_json)
  end
  it 'return 404' do
    parametr = {
        'visitor_id' => 1,
        'document' => '123'
      }
    # подставляем данные, которые должен возвращать сторонний сервис
    stub_request(:get, ENV['PATH_TO_VISITOR_VALIDATE']).with(query: parametr)
    .to_return(status: 404, body: "", headers: {})
    # Получаем ответ метода
    response = ValidateDocumentAdapter.new(ENV['PATH_TO_VISITOR_VALIDATE']).validate_document(1,'123')
    # сравниваем, что получили и что ожидали
    expect(response.status).to eq(404)
  end
end